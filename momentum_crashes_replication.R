# =============================================================================
# momentum_crashes_replication.R -- Byun & Jeon (2023), "Momentum Crashes and the 52-Week High",
# Financial Analysts Journal 79(2).  Rebuild from CRSP legacy monthly +
# CIZ daily + Ken French factors.  Run from the folder that holds the data:
#     Rscript momentum_crashes_replication.R                 # sections 1-7 (data + checkpoints), then stops
#     RUN_TABLES=1 Rscript momentum_crashes_replication.R    # also builds all tables (sections 8+)
# Outputs -> results/.
# =============================================================================
suppressPackageStartupMessages({
  library(data.table); library(tidyverse); library(lubridate)
  library(sandwich); library(lmtest); library(moments)
})
options(width = 160, dplyr.summarise.inform = FALSE)

# ---- 0. CONFIG --------------------------------------------------------------
CFG <- list(
  monthly   = if (file.exists("crsp_monthly_new.csv")) "crsp_monthly_new.csv" else
              "_extract_monthly/pmcrrniszzrpo1hl.csv",   # unzipped from pmcrrniszzrpo1hl_csv.zip
  daily     = "crsp_daily(all).csv",
  ff_m      = "FF3_MOM.csv",
  ff_d      = "FF3_MOM-Daily.csv",
  out       = "results",
  cache     = "results/cache",
  min_price = 5,              # paper: exclude stocks priced below $5 at formation
  min_mom_n = 8,              # >= 8 valid monthly returns in months t-11..t-1
  first_form = c(1926, 12),   # first formation month (first holding month Jan 1927)
  is_start  = c(1930, 1),     # in-sample reporting window start (36m betas need 36 months)
  is_end    = c(2022, 3),     # in-sample end; OOS = Apr 2022 .. Dec 2024
  last_hold = c(2024, 12),
  shumway   = -0.30,
  vwml_target = 0.12, vwml_window = 126L
)
RUN_TABLES <- Sys.getenv("RUN_TABLES") == "1"
dir.create(CFG$out,   showWarnings = FALSE, recursive = TRUE)
dir.create(CFG$cache, showWarnings = FALSE, recursive = TRUE)
LOG <- file.path(CFG$out, "sanity_log.txt")
if (!RUN_TABLES && file.exists(LOG)) file.remove(LOG)
say <- function(...) { s <- paste0(...); cat(s, "\n"); cat(s, "\n", file = LOG, append = TRUE) }
ymk <- function(y, m) as.integer(y) * 12L + as.integer(m) - 1L          # month index
ym2date <- function(ym) as.Date(sprintf("%d-%02d-01", ym %/% 12L, ym %% 12L + 1L)) %m+% months(1) - days(1)
num <- function(x) suppressWarnings(as.numeric(x))
YM <- list(form0 = ymk(CFG$first_form[1], CFG$first_form[2]),
           is0   = ymk(CFG$is_start[1],  CFG$is_start[2]),
           is1   = ymk(CFG$is_end[1],    CFG$is_end[2]),
           last  = ymk(CFG$last_hold[1], CFG$last_hold[2]))
say("momentum_crashes_replication.R started ", format(Sys.time()), " | R ", R.version.string)

# ---- 1. LOAD CRSP LEGACY MONTHLY -------------------------------------------
say("\n=== 1. CRSP monthly: ", CFG$monthly)
say("header: ", paste(names(fread(CFG$monthly, nrows = 0)), collapse = ","))
m <- fread(CFG$monthly, colClasses = list(character = c("RET","RETX","DLRET","DLRETX","DLSTCD","CUSIP","TICKER")))
say("rows: ", format(nrow(m), big.mark = ","), " | PERMNOs: ", format(uniqueN(m$PERMNO), big.mark = ","))
m[, date := as.IDate(date)]
m[, ym := year(date) * 12L + month(date) - 1L]
say("date range: ", format(min(m$date)), " to ", format(max(m$date)))
say("SHRCD: ", paste(names(table(m$SHRCD)), table(m$SHRCD), sep = "=", collapse = " "),
    " | EXCHCD: ", paste(names(table(m$EXCHCD)), table(m$EXCHCD), sep = "=", collapse = " "))
say("duplicate PERMNO-month rows: ", sum(duplicated(m, by = c("PERMNO", "ym"))))
bad_ret <- m$RET[is.na(num(m$RET)) & !is.na(m$RET) & m$RET != ""]
say("RET non-numeric codes: ", paste(names(table(bad_ret)), table(bad_ret), sep = "=", collapse = " "),
    " | RET blank: ", sum(m$RET == "" | is.na(m$RET)))

# market return (CRSP value-weighted incl. distributions), one value per month
mk <- unique(m[, .(ym, vwretd = num(vwretd), ewretd = num(ewretd))])
stopifnot(!anyDuplicated(mk$ym))
setkey(mk, ym)

# ---- 2. TOTAL RETURN (delisting returns compounded in) ----------------------
m[, `:=`(ret = num(RET), dlret = num(DLRET), dlstcd = suppressWarnings(as.integer(DLSTCD)))]
m[, has_dl := !is.na(dlstcd) & dlstcd >= 200L]            # DLSTCD 100 = still active
m[, perf_dl := has_dl & (dlstcd == 500L | (dlstcd >= 520L & dlstcd <= 584L))]
m[, dl_imputed := has_dl & is.na(dlret) & perf_dl]
m[, dl_used := fifelse(dl_imputed, CFG$shumway, dlret)]
m[, ret_total := fcase(
      !is.na(ret) &  !is.na(dl_used), (1 + ret) * (1 + dl_used) - 1,
       is.na(ret) &  !is.na(dl_used), dl_used,
      default = ret)]
n_dl_ret <- sum(!is.na(m$dlret))
say("delisting rows (DLSTCD>=200): ", sum(m$has_dl), " | rows with numeric DLRET: ", n_dl_ret,
    sprintf(" (%.3f%% of PERMNO-months)", 100 * n_dl_ret / nrow(m)),
    " | performance-delist DLRET missing -> -0.30 imputed: ", sum(m$dl_imputed),
    " | non-performance delistings with DLRET missing (left NA): ", sum(m$has_dl & is.na(m$dlret) & !m$perf_dl))
m[, `:=`(prc = abs(num(PRC)), shrout = num(SHROUT), vol = num(VOL))]
m[, mktcap := fifelse(!is.na(prc) & prc > 0 & !is.na(shrout) & shrout > 0, prc * shrout * 1000, NA_real_)]
vm <- m[, .(pct = 100 * mean(is.na(vol))), by = .(dec = year(date) %/% 10L * 10L)][order(dec)]
say("VOL missing share by decade: ", paste0(vm$dec, "s=", round(vm$pct), "%", collapse = " "))

base <- m[, .(permno = PERMNO, ym, date, exch = EXCHCD, prc, shrout, vol, ret, ret_total, mktcap)]
setkey(base, permno, ym)

# ---- 3. MOMENTUM (months t-11 .. t-1, skip t; >= 8 valid) -------------------
say("\n=== 3. Momentum")
lsum <- numeric(nrow(base)); cnt <- integer(nrow(base))
key_dt <- base[, .(permno, ym)]
for (k in 1:11) {
  lag_k <- base[, .(permno, ym = ym + k, r = ret_total)]
  setkey(lag_k, permno, ym)
  rr <- lag_k[key_dt, on = c("permno", "ym")]$r
  ok <- !is.na(rr)
  lsum[ok] <- lsum[ok] + log1p(pmax(rr[ok], -1)); cnt[ok] <- cnt[ok] + 1L
}
base[, mom_n := cnt]
base[, mom := fifelse(cnt >= CFG$min_mom_n, exp(lsum) - 1, NA_real_)]
say("valid momentum stock-months: ", format(sum(!is.na(base$mom)), big.mark = ","))

# ---- 4. NEARHIGH from daily file (index built from dlyret) ------------------
say("\n=== 4. Nearhigh from daily file")
f_dd <- file.path(CFG$cache, "daily_ret.rds")
if (file.exists(f_dd)) {
  dd <- readRDS(f_dd); say("loaded cached daily returns: ", format(nrow(dd), big.mark = ","))
} else {
  say("reading ", CFG$daily, " (select permno, dlycaldt, dlyret) ...")
  dd <- fread(CFG$daily, select = c("permno", "dlycaldt", "dlyret"))
  say("raw daily rows: ", format(nrow(dd), big.mark = ","), " | class(dlycaldt)=", class(dd$dlycaldt)[1])
  dd <- dd[permno %in% unique(base$permno)]                       # drops funds / non-common
  dd[, dlycaldt := as.IDate(dlycaldt)]
  dd <- dd[dlycaldt <= as.IDate(ym2date(YM$last))]
  setkey(dd, permno, dlycaldt)
  dd[, r := fifelse(is.na(dlyret), 0, pmax(dlyret, -0.9999))]
  say("daily rows kept (permnos in monthly file, <= Dec 2024): ", format(nrow(dd), big.mark = ","),
      " | dlyret NA share: ", sprintf("%.3f%%", 100 * mean(is.na(dd$dlyret))))
  dd[, dlyret := NULL]
  saveRDS(dd, f_dd, compress = FALSE)
}
# DATA FIX: the daily file contains duplicated PERMNO-date rows (identical copies; 8, 27, 64, ... copies = k^3,
# i.e. a many-to-many join in the extract). A duplicated -60% day compounded 12x was what produced Nearhigh ~ 1e-12.
dup_cp <- dd[, .N, by = .(permno, dlycaldt)][N > 1L]
say("daily duplicates: ", format(nrow(dup_cp), big.mark = ","), " PERMNO-dates duplicated (", uniqueN(dup_cp$permno),
    " PERMNOs; ", format(sum(dup_cp$N - 1L), big.mark = ","), " surplus rows = ",
    sprintf("%.3f%%", 100 * sum(dup_cp$N - 1L) / nrow(dd)), "); max copies ", max(dup_cp$N))
fwrite(dup_cp[, .(n_permno_dates = .N), by = .(copies = N)][order(copies)], file.path(CFG$out, "daily_duplicate_copies_summary.csv"))
dd <- unique(dd, by = c("permno", "dlycaldt"))
ext <- dd[abs(r) > 5, .(permno, dlycaldt, dlyret = r)][order(permno, dlycaldt)]
fwrite(ext, file.path(CFG$out, "extreme_dlyret_rows_abs_gt5.csv"))
say("rows with |dlyret| > 5 after de-duplication: ", nrow(ext), " (", uniqueN(ext$permno), " PERMNOs); listed in extreme_dlyret_rows_abs_gt5.csv; none altered")
dd[, ym := year(dlycaldt) * 12L + month(dlycaldt) - 1L]
dd[, idx := cumprod(1 + r), by = permno]                           # split/dividend-adjusted price index
dm <- dd[, .(idx_end = idx[.N], idx_max = max(idx)), by = .(permno, ym)]
setkey(dm, permno, ym)
hi <- dm$idx_max; nwin <- rep(1L, nrow(dm)); dkey <- dm[, .(permno, ym)]
for (k in 1:11) {
  x <- dm[, .(permno, ym = ym + k, v = idx_max)]; setkey(x, permno, ym)
  v <- x[dkey, on = c("permno", "ym")]$v
  hi <- pmax(hi, v, na.rm = TRUE); nwin <- nwin + as.integer(!is.na(v))
}
dm[, `:=`(nearhigh = fifelse(hi > 0, idx_end / hi, NA_real_), nwin = nwin)]
dm <- dm[, .(permno, ym, nearhigh, nwin)]
say("Nearhigh stock-months: ", format(nrow(dm), big.mark = ","),
    " | range (", signif(min(dm$nearhigh, na.rm = TRUE), 3), ", ", max(dm$nearhigh, na.rm = TRUE), "]")
base <- dm[base, on = c("permno", "ym")]
setkey(base, permno, ym)
saveRDS(base, file.path(CFG$cache, "base.rds"))

# ---- 5. UNIVERSE (formation month t) ----------------------------------------
say("\n=== 5. Universe")
base[, valid := !is.na(mom) & !is.na(nearhigh) & nwin >= CFG$min_mom_n & !is.na(prc) & prc >= CFG$min_price &
                !is.na(shrout) & shrout > 0 & !is.na(mktcap) & !is.na(ret_total) &
                ym >= YM$form0 & ym < YM$last]
U <- base[valid == TRUE]
say("valid stock-months (formation Dec 1926 .. Nov 2024): ", format(nrow(U), big.mark = ","))
per_month <- U[, .N, by = ym][order(ym)]
avg_all <- mean(per_month$N)
avg_paper <- mean(per_month[ym >= YM$is0 - 1L & ym <= YM$is1 - 1L]$N)   # formation Dec 1929 .. Feb 2022
say(sprintf("average stocks per month, formation Dec 1929-Feb 2022 (holding Jan 1930-Mar 2022): %.1f  [paper: 2,222]", avg_paper))
say(sprintf("average stocks per month, full sample: %.1f", avg_all))
say("min / max stocks in a month: ", min(per_month$N), " / ", max(per_month$N))
share1 <- mean(U$nearhigh >= 1 - 1e-12)
say(sprintf("Nearhigh == 1 (stock at its 12-month daily high): %s stock-months = %.2f%% of valid; months with >=2 tied stocks: %d of %d",
            format(sum(U$nearhigh >= 1 - 1e-12), big.mark = ","), 100 * share1,
            sum(U[, sum(nearhigh >= 1 - 1e-12), by = ym]$V1 >= 2), uniqueN(U$ym)))
say("Nearhigh in (0,1]: ", all(U$nearhigh > 0 & U$nearhigh <= 1 + 1e-12))
say(sprintf("exchange mix (valid): %s", paste(names(table(U$exch)), round(100 * prop.table(table(U$exch)), 1), sep = "=", collapse = "% ")), "%")

# check: valid stock-months with Nearhigh < 0.01 must reflect a real price collapse.  Independent test with the
# monthly total-return index (CRSP RET): ratio = I(t) / max(I(t-11..t)), I = cumulative product of monthly ret_total from t-12.
low <- U[nearhigh < 0.01, .(permno, ym, prc, nearhigh_daily = nearhigh)]
if (nrow(low)) {
  low[, nearhigh_monthly := mapply(function(p, y) {
    r <- base[.(p, (y - 11L):y), ret_total]; r[is.na(r)] <- 0
    I <- cumprod(1 + r); max(c(1, I)); tail(I, 1) / max(c(1, I)) }, permno, ym)]
  low[, consistent := abs(log(nearhigh_daily) - log(pmax(nearhigh_monthly, 1e-12))) < log(3) | nearhigh_monthly < 0.02]
  fwrite(low, file.path(CFG$out, "low_nearhigh_check.csv"))
}
say("valid stock-months with Nearhigh < 0.01 after the fix: ", nrow(low),
    if (nrow(low)) paste0(" | consistent with monthly-return index: ", sum(low$consistent)) else "")

# ---- 6. MARKET REBOUND MONTHS ------------------------------------------------
say("\n=== 6. Market rebound months")
hold <- data.table(ym = YM$form0 + 1L:(YM$last - YM$form0))                 # holding months Jan 1927 ..
hold <- mk[hold, on = "ym"]
mm <- mk$vwretd[match(hold$ym, mk$ym)]
past12 <- sapply(seq_len(nrow(hold)), function(i) {
  idx <- match(hold$ym[i] - 12:1, mk$ym)
  if (anyNA(idx)) NA_real_ else prod(1 + mk$vwretd[idx]) - 1 })
hold[, `:=`(vwretd = mm, mkt_past12 = past12)]
hold[, rebound := fifelse(is.na(mkt_past12), NA, vwretd > 0 & mkt_past12 < 0)]
isw <- hold[ym >= YM$is0 & ym <= YM$is1]
n_reb <- sum(isw$rebound, na.rm = TRUE)
say(sprintf("in-sample holding months Jan 1930-Mar 2022: %d | rebound months: %d  [paper: 157 of 1,107]", nrow(isw), n_reb))
saveRDS(hold, file.path(CFG$cache, "hold.rds"))

# ---- 7. CHECKPOINTS ----------------------------------------------------------
say("\n=== 7. CHECKPOINTS (flag if off by more than 5%)")
chk <- data.table(
  item   = c("avg stocks/month (Jan1930-Mar2022)", "rebound months", "in-sample months"),
  paper  = c(2222, 157, 1107),
  mine   = c(avg_paper, n_reb, nrow(isw)))
chk[, pct_off := 100 * (mine / paper - 1)][, flag := ifelse(abs(pct_off) > 5, "OFF >5%", "ok")]
print(chk); fwrite(chk, file.path(CFG$out, "checkpoints.csv"))
cat(capture.output(print(chk)), sep = "\n", file = LOG, append = TRUE)
if (!RUN_TABLES) { say("\nStopping after checkpoints (set RUN_TABLES=1 to build tables)."); quit(save = "no") }

# ---- 8+. TABLES (RUN_TABLES=1) ----------------------------------------------------

# ---- 8. FACTORS AND HOLDING-MONTH GRID ---------------------------------------
say("\n=== 8. Ken French factors + holding-month grid")
read_ff <- function(path, daily = FALSE) {
  x <- fread(path, skip = 5, header = TRUE, fill = TRUE, colClasses = "character")
  setnames(x, 1, "date")
  x <- x[grepl(if (daily) "^[0-9]{8}$" else "^[0-9]{6}$", trimws(date))]
  for (j in 2:6) set(x, j = j, value = num(x[[j]]))
  x }
ffm <- read_ff(CFG$ff_m)
ffm[, ym := (as.integer(date) %/% 100L) * 12L + as.integer(date) %% 100L - 1L]
ffm[, `:=`(mktrf = `Mkt-RF` / 100, smb = SMB / 100, hml = HML / 100, rf = RF / 100, mom_kf = MOM / 100)]
setkey(ffm, ym)
say("monthly FF rows: ", nrow(ffm), " | ", format(ym2date(min(ffm$ym))), " to ", format(ym2date(max(ffm$ym))))
ffd <- read_ff(CFG$ff_d, daily = TRUE)
ffd[, date := as.IDate(as.character(date), format = "%Y%m%d")]
ffd[, `:=`(mkt = (`Mkt-RF` + RF) / 100)]
say("daily FF rows: ", nrow(ffd), " | ", format(min(ffd$date)), " to ", format(max(ffd$date)))
# market volatility: variance of the previous 126 daily market returns, value at last trading day of each month
setorder(ffd, date)
ffd[, v126 := frollapply(mkt, 126L, var)]
ffd[, ym := year(date) * 12L + month(date) - 1L]
mktvol_m <- ffd[, .(v126 = v126[.N]), by = ym]

grid <- data.table(ym = (YM$form0 + 1L):YM$last)
grid <- merge(grid, ffm[, .(ym, mktrf, smb, hml, rf, mom_kf)], by = "ym", all.x = TRUE)
grid <- merge(grid, hold[, .(ym, vwretd, mkt_past12, rebound)], by = "ym", all.x = TRUE)
grid <- merge(grid, mktvol_m[, .(ym = ym + 1L, mktvol = v126)], by = "ym", all.x = TRUE)   # known at end of t-1
setkey(grid, ym)
stopifnot(nrow(grid) == YM$last - YM$form0)
Xc <- as.matrix(grid[, .(mktrf)]); Xf <- as.matrix(grid[, .(mktrf, smb, hml)])
inW <- grid$ym >= YM$is0 & grid$ym <= YM$is1; oosW <- grid$ym > YM$is1
isReb <- inW & grid$rebound %in% TRUE; isNon <- inW & grid$rebound %in% FALSE
say("in-sample months: ", sum(inW), " (rebound ", sum(isReb), ", non-rebound ", sum(isNon), ") | OOS months: ", sum(oosW))

# ---- 9. ADJUSTED RETURNS (rolling past-36-month betas) -----------------------
adj_series <- function(y, X, win = 36L) {            # y - X %*% beta, beta from months t-36..t-1 (with intercept)
  n <- length(y); out <- rep(NA_real_, n)
  for (t in (win + 1L):n) {
    w <- (t - win):(t - 1L)
    yy <- y[w]; XX <- X[w, , drop = FALSE]
    if (anyNA(yy) || anyNA(XX) || is.na(y[t]) || anyNA(X[t, ])) next
    Z <- cbind(1, XX)
    b <- tryCatch(solve(crossprod(Z), crossprod(Z, yy)), error = function(e) NULL)
    if (!is.null(b)) out[t] <- y[t] - sum(X[t, ] * b[-1])
  }
  out }
adj <- function(r, ty) switch(ty, MAR = r - grid$vwretd, CAPM = adj_series(r - grid$rf, Xc), FF = adj_series(r - grid$rf, Xf))
adj_spread <- function(s, ty) switch(ty, MAR = s, CAPM = adj_series(s, Xc), FF = adj_series(s, Xf))
mean_hc0 <- function(v) {                             # mean and White(HC0) t-stat = dummy regression without intercept
  v <- v[!is.na(v)]; n <- length(v); if (n < 3) return(c(NA_real_, NA_real_))
  m <- mean(v); c(m, m / (sqrt(sum((v - m)^2)) / n)) }
stars <- function(t) ifelse(is.na(t), "", ifelse(abs(t) >= 2.576, "**", ifelse(abs(t) >= 1.96, "*", "")))
fmtc  <- function(m, t) ifelse(is.na(m), NA_character_, paste0(sprintf("%.2f", m), stars(t)))

# ---- 10. PORTFOLIO FORMATION -------------------------------------------------
say("\n=== 10. Portfolios (equal-count sorts, value-weighted at formation)")
bucket <- function(rk, n, k) pmin(as.integer(floor(k * (rk - 1) / n) + 1L), k)
form_ranks <- function(D) {
  D <- copy(D); D[, N := .N, by = ym]
  D[, rk_mom := frank(mom, ties.method = "first"), by = ym]
  D[, rk_nh  := frank(nearhigh, ties.method = "average"), by = ym]   # ties (Nearhigh == 1) share one bucket
  D[, `:=`(mom_dec = bucket(rk_mom, N, 10L), mom_q = bucket(rk_mom, N, 5L),
           nh_dec  = bucket(rk_nh,  N, 10L), nh_q  = bucket(rk_nh,  N, 5L))]
  D[, mom_in      := bucket(frank(mom, ties.method = "first"), .N, 10L), by = .(ym, nh_q)]
  D[, mom_q_in_nh := bucket(frank(mom, ties.method = "first"), .N, 5L),  by = .(ym, nh_q)]
  D[, nh_in_q     := bucket(frank(nearhigh, ties.method = "average"), .N, 5L), by = .(ym, mom_q)]
  D }
hr <- base[, .(permno, ym = ym - 1L, hret = ret_total)]; setkey(hr, permno, ym)       # return of month t+1
attach_hret <- function(D, hr) hr[D, on = c("permno", "ym")]
U <- attach_hret(U, hr)
say("formation stock-months without a holding-month return (dropped from portfolio returns): ",
    format(sum(is.na(U$hret)), big.mark = ","), sprintf(" (%.2f%%)", 100 * mean(is.na(U$hret))))
vwp <- function(D, by) D[!is.na(hret), .(ret = sum(mktcap * hret) / sum(mktcap), n = .N,
                                          avg_mom = 100 * mean(mom), avg_nh = 100 * mean(nearhigh)), by = by]
mk_port <- function(D) {
  P <- list(mom = vwp(D, c("ym", "mom_dec")), nh = vwp(D, c("ym", "nh_dec")),
            p50 = vwp(D, c("ym", "nh_q", "mom_in")),
            p2A = vwp(D, c("ym", "nh_q", "mom_q_in_nh")), p2B = vwp(D, c("ym", "mom_q", "nh_in_q")))
  P$star <- P$p50[, .(ret = mean(ret), avg_mom = mean(avg_mom), avg_nh = mean(avg_nh), nq = .N), by = .(ym, mom_in)]
  P }
ser <- function(P, col, lev, v = "ret") { x <- P[get(col) == lev]; x[[v]][match(grid$ym, x$ym + 1L)] }
U <- form_ranks(U)
P <- mk_port(U)
S_mom  <- lapply(1:10, function(d) ser(P$mom, "mom_dec", d))
S_nh   <- lapply(1:10, function(d) ser(P$nh,  "nh_dec",  d))
S_star <- lapply(1:10, function(d) ser(P$star, "mom_in", d))
wml  <- S_mom[[10]]  - S_mom[[1]]
wmls <- S_star[[10]] - S_star[[1]]
say("star portfolios: avg number of Nearhigh-quintile cells per D*: ", round(mean(P$star$nq), 3))
say(sprintf("WML in-sample: mean %.3f%% sd %.3f%% | WML*: mean %.3f%% sd %.3f%%",
            100 * mean(wml[inW], na.rm = TRUE), 100 * sd(wml[inW], na.rm = TRUE),
            100 * mean(wmls[inW], na.rm = TRUE), 100 * sd(wmls[inW], na.rm = TRUE)))

# ---- 11. V-WML (Barroso & Santa-Clara style; ASSUMPTION: 126-day sigma, 12% target, no cap) -------------
say("\n=== 11. V-WML")
Lw <- U[mom_dec %in% c(1L, 10L), .(permno, ym = ym + 1L, side = fifelse(mom_dec == 10L, 1, -1), w = mktcap)]
dj <- dd[Lw, on = c("permno", "ym"), nomatch = 0L, .(dlycaldt, ym, r, side, w)]
say("daily leg rows: ", format(nrow(dj), big.mark = ","))
dwml <- dj[, .(wml_d = sum(w[side == 1] * r[side == 1]) / sum(w[side == 1]) -
                       sum(w[side == -1] * r[side == -1]) / sum(w[side == -1])), by = dlycaldt]
setorder(dwml, dlycaldt)
dwml[, `:=`(sd126 = frollapply(wml_d, CFG$vwml_window, sd), ym = year(dlycaldt) * 12L + month(dlycaldt) - 1L)]
sig <- dwml[, .(sd126 = sd126[.N]), by = ym][!is.na(sd126)]
sig[, `:=`(sigma_ann = sd126 * sqrt(252), weight = CFG$vwml_target / (sd126 * sqrt(252)), ym_hold = ym + 1L)]
vwml <- wml * sig$weight[match(grid$ym, sig$ym_hold)]
fwrite(sig[, .(ym, month_end = ym2date(ym), sigma_ann, weight)], file.path(CFG$cache, "vwml_weights.csv"))
say(sprintf("V-WML months available: %d (in-sample %d, OOS %d) | weight mean %.2f, min %.2f, max %.2f",
            sum(!is.na(vwml)), sum(!is.na(vwml[inW])), sum(!is.na(vwml[oosW])),
            mean(sig$weight), min(sig$weight), max(sig$weight)))
say(sprintf("V-WML in-sample realised sd = %.3f%% (paper 4.65%%); WML sd on same months = %.3f%%; mean %.3f%% (paper 1.24%%)",
            100 * sd(vwml[inW], na.rm = TRUE), 100 * sd(wml[inW & !is.na(vwml)], na.rm = TRUE), 100 * mean(vwml[inW], na.rm = TRUE)))
rm(dj, Lw); gc(verbose = FALSE)

# ---- 12. TABLE 1 -------------------------------------------------------------
say("\n=== 12. Tables")
t1_panel <- function(S, pan) {
  rows <- list()
  for (ty in c("MAR", "CAPM", "FF")) {
    A <- lapply(1:10, function(d) 100 * adj(S[[d]], ty)); A[[11]] <- 100 * adj_spread(S[[10]] - S[[1]], ty)
    for (st in 1:2) {
      flag <- if (st == 1) isReb else isNon
      cells <- sapply(1:11, function(j) { r <- mean_hc0(A[[j]][flag]); fmtc(r[1], r[2]) })
      rows[[length(rows) + 1]] <- as.data.table(c(list(Panel = sprintf("%s%d. %s", pan, st, c("Market Rebounds", "Non-Rebounds")[st]),
                                                      Metric = ty), setNames(as.list(cells), c(paste0("D", 1:10), "10 - 1")),
                                                  list(Definition = "10 - 1 = decile 10 minus decile 1")))
    } }
  rbindlist(rows) }
t1 <- rbindlist(list(t1_panel(S_mom, "A"), t1_panel(S_nh, "B")))
t1 <- t1[order(substr(Panel, 1, 2), match(Metric, c("MAR", "CAPM", "FF")))]
fwrite(t1, file.path(CFG$out, "table1_univariate_sort.csv"))
print(t1[, .(Panel, Metric, D1, D10, `10 - 1`)])

# ---- TABLE 2 ----------------------------------------------------------------
mar_state <- function(P, c1, c2, l1, l2, flag) {
  x <- P[get(c1) == l1 & get(c2) == l2]; y <- 100 * (x$ret[match(grid$ym, x$ym + 1L)] - grid$vwretd)
  mean(y[flag], na.rm = TRUE) }
t2_rows <- list()
for (st in 1:2) {
  flag <- if (st == 1) isReb else isNon
  for (a in 1:5) {
    v <- sapply(1:5, function(b) mar_state(P$p2A, "nh_q", "mom_q_in_nh", a, b, flag))
    t2_rows[[length(t2_rows) + 1]] <- data.table(NH = c("NH Q1 (Far)", paste0("NH Q", 2:4), "NH Q5 (Near)")[a],
      Q1 = v[1], Q2 = v[2], Q3 = v[3], Q4 = v[4], Q5 = v[5], `5 - 1` = v[5] - v[1],
      Panel = c("A3-Reb", "A4-NonReb")[st], Mom = NA_character_, NH_Q1 = NA_real_, NH_Q2 = NA_real_, NH_Q3 = NA_real_, NH_Q4 = NA_real_, NH_Q5 = NA_real_)
  } }
for (st in 1:2) {
  flag <- if (st == 1) isReb else isNon
  for (a in 1:5) {
    v <- sapply(1:5, function(b) mar_state(P$p2B, "mom_q", "nh_in_q", a, b, flag))
    t2_rows[[length(t2_rows) + 1]] <- data.table(NH = NA_character_, Q1 = NA_real_, Q2 = NA_real_, Q3 = NA_real_, Q4 = NA_real_, Q5 = NA_real_,
      `5 - 1` = v[5] - v[1], Panel = c("B1-Reb", "B2-NonReb")[st],
      Mom = c("Mom Q1 (Loser)", paste0("Mom Q", 2:4), "Mom Q5 (Winner)")[a],
      NH_Q1 = v[1], NH_Q2 = v[2], NH_Q3 = v[3], NH_Q4 = v[4], NH_Q5 = v[5])
  } }
t2 <- rbindlist(t2_rows); t2[, (c(2:7, 10:14)) := lapply(.SD, round, 2), .SDcols = c(2:7, 10:14)]
fwrite(t2, file.path(CFG$out, "table2_bivariate_sort.csv"))

# ---- TABLE 3 ----------------------------------------------------------------
t3_rows <- list()
for (st in 1:2) {
  flag <- if (st == 1) isReb else isNon; pl <- c("A. Market Rebounds", "B. Non-Rebounds")[st]
  nh_v  <- sapply(1:10, function(d) mean(ser(P$star, "mom_in", d, "avg_nh")[flag], na.rm = TRUE))
  mo_v  <- sapply(1:10, function(d) mean(ser(P$star, "mom_in", d, "avg_mom")[flag], na.rm = TRUE))
  add_chr <- function(metric, v) t3_rows[[length(t3_rows) + 1]] <<- as.data.table(c(list(Panel = pl, Metric = metric),
              setNames(as.list(sprintf("%.2f", v)), paste0("D", 1:10)), list(`WML*` = sprintf("%.2f", v[10] - v[1]), Definition = "WML* = D10* minus D1*")))
  add_chr("Nearhigh", nh_v); add_chr("Momentum", mo_v)
  for (ty in c("MAR", "CAPM", "FF")) {
    A <- lapply(1:10, function(d) 100 * adj(S_star[[d]], ty)); A[[11]] <- 100 * adj_spread(S_star[[10]] - S_star[[1]], ty)
    cells <- sapply(1:11, function(j) { r <- mean_hc0(A[[j]][flag]); fmtc(r[1], r[2]) })
    t3_rows[[length(t3_rows) + 1]] <- as.data.table(c(list(Panel = pl, Metric = ty), setNames(as.list(cells[1:10]), paste0("D", 1:10)),
                                                      list(`WML*` = cells[11], Definition = "WML* = D10* minus D1*")))
  } }
t3 <- rbindlist(t3_rows); fwrite(t3, file.path(CFG$out, "table3_wmlstar_detail.csv"))
print(t3[, .(Panel, Metric, D1, D10, `WML*`)])

# ---- TABLE 5 ----------------------------------------------------------------
reb_row <- function(label, y) {
  a <- mean_hc0(100 * y[isReb]); b <- mean_hc0(100 * y[isNon])
  data.table(Strategy = label, Reb_avg_pct = round(a[1], 3), Reb_tstat = round(a[2], 2),
             NoReb_avg_pct = round(b[1], 3), NoReb_tstat = round(b[2], 2), Diff_pct = round(a[1] - b[1], 3)) }
t5 <- rbindlist(list(reb_row("WML All CRSP", wml), reb_row("WML* All CRSP", wmls), reb_row("V-WML All CRSP", vwml),
                     reb_row("WML Ken French MOM (reference)", grid$mom_kf)))
fwrite(t5, file.path(CFG$out, "table5_rebound_regression.csv")); print(t5)

# ---- TABLE 6 ----------------------------------------------------------------
t6d <- data.table(WML = wml, WML_star_all = wmls, Mktret = grid$mkt_past12, Mktvol = grid$mktvol,
                  I_Jan = as.numeric(ym2date(grid$ym) |> month() == 1L))[inW]
t6d[, Mktret2 := Mktret^2]
run_t6 <- function(fml, label, k) {
  fm <- lm(as.formula(fml), data = t6d); ct <- unclass(coeftest(fm, vcov = vcovHC(fm, type = "HC0")))
  st <- ifelse(ct[, 4] < 0.01, "**", ifelse(ct[, 4] < 0.05, "*", ""))
  data.frame(Strategy = label, Model = k, term = rownames(ct), Estimate = round(ct[, 1], 4), Stars = st, tstat = round(ct[, 3], 2),
             N = nrow(fm$model), AdjR2 = round(summary(fm)$adj.r.squared * 100, 2), stringsAsFactors = FALSE) }
t6 <- rbind(run_t6("WML ~ Mktret + Mktret2", "WML", 1), run_t6("WML ~ Mktvol", "WML", 2), run_t6("WML ~ I_Jan", "WML", 3),
            run_t6("WML_star_all ~ Mktret + Mktret2", "WML*", 6), run_t6("WML_star_all ~ Mktvol", "WML*", 7), run_t6("WML_star_all ~ I_Jan", "WML*", 8))
t6$EstStar <- paste0(t6$Estimate, t6$Stars)
nc <- rbind(data.frame(Strategy = c("WML", "WML*"), Model = c("paper 2 / 7", "paper 2 / 7"), term = "Mktilliq", Estimate = NA, Stars = "", tstat = NA, N = NA, AdjR2 = NA, EstStar = "not computed (needs daily volume)"),
            data.frame(Strategy = c("WML", "WML*"), Model = c("paper 5 / 10", "paper 5 / 10"), term = "Div, Yld, Term, Def", Estimate = NA, Stars = "", tstat = NA, N = NA, AdjR2 = NA, EstStar = "not computed (needs FRED/Chordia-Shivakumar macro data)"))
t6 <- rbind(t6, nc); fwrite(t6, file.path(CFG$out, "table6_time_variation.csv"))

# ---- TABLE 7 ----------------------------------------------------------------
mstats <- function(y) { y <- 100 * y[!is.na(y)]
  c(Average = mean(y), Std_Dev = sd(y), Skew = skewness(y), Kurt = kurtosis(y), Min = min(y), Max = max(y), Sharpe = mean(y) / sd(y)) }
t7_rows <- list()
for (smp in c("In-Sample", "OOS")) for (ty in c("MAR", "CAPM", "FF")) {
  w <- if (smp == "In-Sample") inW else oosW
  for (nm in c("WML (All CRSP)", "WML*", "V-WML")) {
    y <- adj_spread(switch(nm, `WML (All CRSP)` = wml, `WML*` = wmls, `V-WML` = vwml), ty)[w]
    s <- mstats(y)
    t7_rows[[length(t7_rows) + 1]] <- data.table(Strategy = sprintf("%s [%s]", nm, smp), t(round(s, 4)), N = sum(!is.na(y)), Panel = ty)
  } }
t7 <- rbindlist(t7_rows); fwrite(t7, file.path(CFG$out, "table7_moments.csv")); print(t7[Panel == "MAR"])

# ---- TABLE A1 ---------------------------------------------------------------
wi <- which(inW & !is.na(wml)); worst <- wi[order(wml[wi])][1:10]
capm_w <- adj_spread(wml, "CAPM"); capm_s <- adj_spread(wmls, "CAPM"); ff_w <- adj_spread(wml, "FF"); ff_s <- adj_spread(wmls, "FF")
a1 <- data.table(Date = format(ym2date(grid$ym[worst]), "%b %Y"), Mkt_pct = 100 * grid$vwretd[worst], WML_pct = 100 * wml[worst],
                 WML_star_pct = 100 * wmls[worst], VWML_pct = 100 * vwml[worst], WML_capm = 100 * capm_w[worst], WML_star_capm = 100 * capm_s[worst],
                 WML_ff = 100 * ff_w[worst], WML_star_ff = 100 * ff_s[worst])
a1 <- rbind(a1, c(list(Date = "Average"), lapply(a1[, -1], mean, na.rm = TRUE)))
a1 <- cbind(a1[, 1], round(a1[, -1], 2)); a1[, Definition := "WML = decile 10 minus decile 1 (D10 - D1), value-weighted, excess/raw spread"]
fwrite(a1, file.path(CFG$out, "tableA1_crash_months.csv")); print(a1[, 1:6])

# ---- TABLE A4 ---------------------------------------------------------------
per <- list(c(1930, 1949), c(1950, 1969), c(1970, 1989), c(1990, 2009), c(2010, 2022))
a4 <- rbindlist(lapply(per, function(p) {
  w <- grid$ym >= ymk(p[1], 1) & grid$ym <= min(ymk(p[2], 12), YM$is1)
  f <- function(y) { y <- 100 * y[w]; y <- y[!is.na(y)]; c(mean(y), sd(y), mean(y) / sd(y)) }
  a <- f(wml); b <- f(wmls); v <- f(vwml)
  data.table(Period = sprintf("%d-%d", p[1], p[2]), N = sum(w), WML_avg = a[1], WML_sd = a[2], WML_sr = a[3],
             WMLs_avg = b[1], WMLs_sd = b[2], WMLs_sr = b[3], VWML_avg = v[1], VWML_sd = v[2], VWML_sr = v[3]) }))
a4[, (3:11) := lapply(.SD, round, 3), .SDcols = 3:11]; fwrite(a4, file.path(CFG$out, "tableA4_subperiod.csv")); print(a4)
saveRDS(list(grid = grid, wml = wml, wmls = wmls, vwml = vwml, S_mom = S_mom, S_nh = S_nh, S_star = S_star),
        file.path(CFG$cache, "series.rds"))

# ---- 13. TABLE 8 -------------------------------------------------------------
say("\n=== 13. Table 8 (trading frictions)")
# 13a. Abdi-Ranaldo (2017) two-day spread from daily close/high/low.  Free the heavy daily object first.
rm(dd, dm, dwml, dj); invisible(gc(verbose = FALSE))
f_ar <- file.path(CFG$cache, "ar_monthly.rds")
if (file.exists(f_ar)) { arm <- readRDS(f_ar) } else {
  da <- fread(CFG$daily, select = c("permno", "dlycaldt", "dlyclose", "dlyhigh", "dlylow", "dlyret"))
  da <- da[permno %in% unique(base$permno)]; da[, dlycaldt := as.IDate(dlycaldt)]
  da <- unique(da, by = c("permno", "dlycaldt")); da <- da[dlycaldt <= as.IDate(ym2date(YM$last))]; setkey(da, permno, dlycaldt)
  say("daily rows for spreads: ", format(nrow(da), big.mark = ","))
  pm <- sort(unique(da$permno)); chunks <- split(pm, cut(seq_along(pm), 6, labels = FALSE)); out <- list()
  for (ch in chunks) {
    d <- da[.(ch)]
    d[, `:=`(hi = abs(dlyhigh), lo = abs(dlylow), cl = abs(dlyclose))]
    d[!(is.finite(hi) & is.finite(lo) & is.finite(cl) & lo > 0 & hi >= lo & cl >= lo & cl <= hi), `:=`(hi = NA_real_, lo = NA_real_, cl = NA_real_)]
    d[, `:=`(c = log(cl), eta = (log(hi) + log(lo)) / 2)]
    d[, `:=`(eta_n = shift(eta, -1L), c_n = shift(c, -1L), ret_n = shift(dlyret, -1L)), by = permno]
    d[, pr := 4 * (c - eta) * (c - eta_n)]
    d[!is.na(ret_n) & abs((c_n - c) - log1p(pmax(ret_n, -0.9999))) > 0.3, pr := NA_real_]      # drop splits / stale pairs
    d[, ym := year(dlycaldt) * 12L + month(dlycaldt) - 1L]
    out[[length(out) + 1]] <- d[, .(s2 = mean(pr, na.rm = TRUE), nd = sum(!is.na(pr))), by = .(permno, ym)][nd >= 10L]
  }
  arm <- rbindlist(out); arm[, spread := 100 * sqrt(pmax(s2, 0))]; arm <- arm[, .(permno, ym, spread)]
  setkey(arm, permno, ym); saveRDS(arm, f_ar); rm(da, d, out); invisible(gc(verbose = FALSE))
}
say("Abdi-Ranaldo stock-months: ", format(nrow(arm), big.mark = ","), " | mean spread ", round(mean(arm$spread), 3), "%")
# 13b. legs
leg_def <- list(
  `Long (Winner)`   = U[mom_dec == 10L, .(permno, w = mktcap / sum(mktcap)), by = ym],
  `Short (Loser)`   = U[mom_dec == 1L,  .(permno, w = mktcap / sum(mktcap)), by = ym],
  `Long (Winner*)`  = U[mom_in == 10L,  .(permno, w = 0.2 * mktcap / sum(mktcap)), by = .(ym, nh_q)][, .(permno, w = w / sum(w)), by = ym],
  `Short (Loser*)`  = U[mom_in == 1L,   .(permno, w = 0.2 * mktcap / sum(mktcap)), by = .(ym, nh_q)][, .(permno, w = w / sum(w)), by = ym])
turn_tbl <- function(Lg) {                          # share of the leg's value replaced at each rebalance = 0.5 * sum|w_new - w_drifted|
  Lg <- merge(Lg, U[, .(permno, ym, hret)], by = c("permno", "ym"))
  a <- Lg[, .(permno, ym = ym + 1L, wd = w * (1 + fifelse(is.na(hret), 0, hret)))][, wd := wd / sum(wd), by = ym]
  j <- merge(a, Lg[, .(permno, ym, w)], by = c("permno", "ym"), all = TRUE)
  j[is.na(wd), wd := 0][is.na(w), w := 0]
  j[, .(turn = 0.5 * sum(abs(w - wd))), by = ym][ym %in% Lg$ym] }
fw0 <- YM$is0 - 1L; fw1 <- YM$is1 - 1L                                        # formation months of the in-sample window
t8 <- rbindlist(lapply(names(leg_def), function(nm) {
  Lg <- leg_def[[nm]]
  M <- merge(Lg, U[, .(permno, ym, mktcap, vol, shrout, prc, ret)], by = c("permno", "ym"))
  M <- merge(M, arm, by = c("permno", "ym"), all.x = TRUE)
  mm <- M[ym >= fw0 & ym <= fw1, .(mc = median(mktcap) / 1e9,
        to  = if (all(is.na(vol))) NA_real_ else median(vol * 100 / (shrout * 1000), na.rm = TRUE),
        ami = { z <- abs(ret) / (prc * vol * 100); z[!is.finite(z)] <- NA; if (all(is.na(z))) NA_real_ else 1e6 * mean(z, na.rm = TRUE) },
        ba  = if (all(is.na(spread))) NA_real_ else mean(spread, na.rm = TRUE), nstk = .N), by = ym]
  tt <- turn_tbl(Lg)[ym >= fw0 & ym <= fw1]
  data.table(Portfolio = nm, MktCap = round(mean(mm$mc), 4), ShareTurnover = round(mean(mm$to, na.rm = TRUE), 4),
             Amihud = round(mean(mm$ami, na.rm = TRUE), 4), BASpread = round(mean(mm$ba, na.rm = TRUE), 4),
             Turnover = round(mean(tt$turn), 4), avg_stocks_in_leg = round(mean(mm$nstk), 1),
             months_with_volume = sum(!is.na(mm$to)), months_with_spread = sum(!is.na(mm$ba)), months_total = nrow(mm),
             Note = "mktcap & share turnover: monthly cross-sectional median then averaged over months; Amihud = monthly approximation 1e6*mean(|ret|/($vol)), VOL in 100-share units; spread = Abdi-Ranaldo; turnover = 0.5*sum|dw|")
}))
fwrite(t8, file.path(CFG$out, "table8_trading_frictions.csv")); print(t8[, 1:7])

say("\nDONE ", format(Sys.time()))
