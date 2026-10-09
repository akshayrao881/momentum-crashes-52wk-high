# Sanity report: momentum_crashes_replication.R

Run: 2026-10-09 11:47:29 . Inputs: `crsp_monthly` legacy file (unzipped from `pmcrrniszzrpo1hl_csv.zip` into `_extract_monthly/`, since `crsp_monthly_new.csv` was not in the folder; header identical to the spec), `crsp_daily(all).csv`, `FF3_MOM*.csv`. Nothing was committed or pushed; no CRSP-derived file is in a git repo.

## 1. Checkpoints

| item | paper | mine | pct_off | flag |
|---|---|---|---|---|
| avg stocks/month (Jan1930-Mar2022) | 2,222.0 | 2,334.3 | 5.05 | OFF >5% |
| rebound months | 157 | 157 | 0 | ok |
| in-sample months | 1,107.0 | 1,107.0 | 0 | ok |

- **Stocks per month: +5.05% vs the paper (2,334.3 vs 2,222): UNEXPLAINED.** Decision: continue with the literal rule (price ≥ $5). Variants tried: also requiring a valid holding-month return 2,331; strict price > $5 2,322 (+4.5%); no price filter 3,053.
- The period averages (645 stocks/month in 1930-49, 1,274 in 1950-69, 3,196 in 1970-89, 3,938 in 1990-2009, 2,816 in 2010-22) **cannot be compared with the paper's single average of 2,222**: the paper gives no breakdown, and the average is very sensitive to which months are included.
- Rebound months: **157 of 1,107**, exact (rebound = value-weighted market return > 0 in month t+1 and cumulative return of the 12 months ending month t < 0).

## 2. Data note: duplicated rows in the daily CRSP extract

`crsp_daily(all).csv` contains duplicated PERMNO-date rows (an artefact of a many-to-many join in the extract): 21,399 PERMNO-dates across 3,767 PERMNOs, 160,718 surplus rows (0.194% of rows), up to 343 copies of one date. The copies are identical in every field and come in cubes (8, 27, 64, 125, 216, 343 copies):

| copies | n_permno_dates |
|---|---|
| 8 | 20924 |
| 27 | 446 |
| 64 | 22 |
| 125 | 4 |
| 216 | 2 |
| 343 | 1 |

Left in, a duplicated large-loss day compounds in the price index and drives Nearhigh toward zero. The script keeps one row per PERMNO-date everywhere the daily file is used (Nearhigh, V-WML daily returns, spreads).

Check after de-duplication: 21 valid stock-months have Nearhigh < 0.01. An independent test against the monthly total-return index (CRSP `RET` accumulated over months t-11..t relative to its window maximum) finds all 21 consistent, i.e. the stocks really fell that much (prices above $5 reflect reverse splits after the collapse). 75 daily returns in the de-duplicated file exceed 500% in absolute value; none are altered.

## 3. Return and universe counts

- delisting rows (DLSTCD>=200): 22768 | rows with numeric DLRET: 22635 (0.591% of PERMNO-months) | performance-delist DLRET missing -> -0.30 imputed: 109 | non-performance delistings with DLRET missing (left NA): 24 
- RET non-numeric codes: C=28067 | RET blank: 41971 
- VOL missing share by decade: 1920s=3% 1930s=0% 1940s=0% 1950s=0% 1960s=0% 1970s=42% 1980s=14% 1990s=0% 2000s=0% 2010s=0% 2020s=0% 
- Valid formation stock-months: 2,697,645 . Exchange mix of valid stock-months (NYSE/AMEX/NASDAQ): 1=47.6% 2=9.9% 3=42.6% 
- Nearhigh ties: Nearhigh == 1 (stock at its 12-month daily high): 145,538 stock-months = 5.40% of valid; months with >=2 tied stocks: 1099 of 1176 . Handled explicitly: stocks with Nearhigh = 1 receive the same (average) rank and therefore always fall in the same decile/quintile (top bucket), so buckets are not exactly equal-sized in those months.
- Formation stock-months without a holding-month return (dropped from portfolio returns): 3,946 (0.15%) 
- Daily dlyret missing: 2.08% of rows (treated as a 0 return in the index and in daily V-WML returns).

## 4. Rules not followed exactly / assumptions (with reasons)

1. **Sample start**: formation from Dec 1926 (first holding month Jan 1927) so that 36-month betas exist from Jan 1930; the prompt's 'stocks enter from Jan 1927' is ambiguous.
2. **Nearhigh window**: requires ≥ 8 months with daily data in the 12-month window (same 'at least eight months' logic as Momentum). Index built from `dlyret` (so it includes distributions), dlyret clipped at −0.9999, NA → 0.
3. **Stock valid at formation** also requires a non-missing month-t `ret_total`.
4. **Ties**: see §3 (shared bucket via average rank; the paper gives no rule).
5. **Bucket sizes**: equal-count by rank (`floor(k(rank−1)/n)+1`), no NYSE breakpoints (paper gives none).
6. **Betas**: rolling past 36 months with intercept, all 36 observations required; adjusted return = excess return − Σβf (no alpha). Spreads adjusted directly (identical to the difference of the legs' adjusted returns).
7. **V-WML scheme is an assumption**: daily WML = fixed-weight (formation market cap) value-weighted decile 10 minus decile 1 using the prior month-end assignment; σ̂ = sd of previous 126 daily WML returns × √252 at month-end; weight = 0.12/σ̂; no cap. Result: in-sample sd 4.704% (paper 4.65%).
8. **Table 8**: market cap and share turnover = per-month cross-sectional **median** then averaged over formation months Dec 1929-Feb 2022; Amihud = **monthly approximation** 1e6·mean(|ret|/(|PRC|·VOL·100)) (VOL in 100-share units), averaged; bid-ask = Abdi-Ranaldo two-day estimator (monthly mean of 4(c−η_t)(c−η_{t+1}), floored at 0, sqrt, ×100), pairs with a price jump inconsistent with dlyret (> 0.3 in logs, splits) dropped, ≥ 10 valid pairs per month; portfolio turnover = 0.5·Σ|w_new − w_drifted| per leg (WML* legs = equal-weight of five NH-quintile portfolios).
9. **Volume/spread coverage** (share of valid stock-months missing in Table 8 window, by decade; averages use available stocks only, so 1970s-80s share turnover and Amihud are based on partial coverage):

| dec | valid_stock_months | vol_missing_pct | spread_missing_pct |
|---|---|---|---|
| 1920 | 539 | 0 | 17.6 |
| 1930 | 65460 | 0 | 25.6 |
| 1940 | 89227 | 0 | 24.1 |
| 1950 | 117712 | 0 | 10.2 |
| 1960 | 188081 | 0 | 5.1 |
| 1970 | 332587 | 30.4 | 33.7 |
| 1980 | 434447 | 11.7 | 27.6 |
| 1990 | 516080 | 0 | 9.8 |
| 2000 | 429056 | 0 | 4.9 |
| 2010 | 336499 | 0 | 1.9 |
| 2020 | 74366 | 0 | 1.2 |

10. **Table 6**: Mktilliq and the macro predictors (paper models 2 and 5/10) are not computed (marked in the file). Mktvol is the variance of the previous 126 daily market returns (paper's scaling not stated), so its coefficient is not comparable in size.
11. **Out-of-sample window**: Apr 2022 to Dec 2024 = 33 months (monthly data end Dec 2024).
12. **Table A1** uses the in-sample window Jan 1930-Mar 2022, ranking by WML (D10−D1) market-adjusted spread; CAPM/FF columns added.
