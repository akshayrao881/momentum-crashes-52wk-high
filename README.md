# Momentum Crashes and the 52-Week High

**Business question:** Momentum earns a premium but suffers rare one-month crashes of 30–70%. Does one extra sort, on how close a stock is to its 52-week high, remove the crash risk?

Replication and out-of-sample extension of Byun & Jeon (2023), *Financial Analysts Journal* 79(2), for FINC671 (Workshop in Finance, University of Delaware, Spring 2026; faculty advisor Prof. Paul Laux). The code is `momentum_crashes_replication.R`, which builds everything from raw CRSP data.

## Result in brief
The code reproduces the paper's main findings. Standard momentum (WML) crashes when the market rebounds. A Nearhigh-neutral version (WML\*) removes the crash exposure without losing profit. Of 378 statistics that can be compared with the paper, **183 match, 117 have a small gap and 78 a large gap** (`results/comparison_paper_vs_replication.md`; status rules are stated there).

Market-adjusted, in sample (Jan 1930 – Mar 2022, 1,107 months; 157 market-rebound months, as in the paper):

| Statistic | Paper | Replication |
|---|---|---|
| WML mean / sd / skew / Sharpe | 1.19 / 7.51 / −1.89 / 0.159 | **1.22 / 7.49 / −1.90 / 0.163** |
| WML worst month | −74.06% | **−73.82%** (Jul 1932) |
| WML\* mean / sd / skew / Sharpe | 1.37 / 4.96 / 0.13 / 0.276 | **1.38 / 5.00 / 0.04 / 0.276** |
| WML\* worst month | −23.66% | −26.71% |
| WML\* kurtosis | 4.5 | 7.7 |
| WML return in rebound months (Table 5) | −4.13% | **−4.17%** (t = −4.56) |
| WML\* return in rebound months (Table 3) | +1.27% | **+1.15%** (t ≈ 2.6) |
| Table 1 A1, momentum decile 10 − 1: MAR / CAPM / FF | −4.13 / −2.26 / −1.94 | **−4.17 / −2.25 / −2.01** |
| Table 1 B1, Nearhigh decile 10 − 1, MAR | −6.91 | −7.13 |
| 10 largest WML crash months: average WML / WML\* | −37.80% / −6.76% | −37.38% / −8.66% |

The 10 crash months in Table A1 are the same 10 months as the paper's. The one large miss is Jul 1932, where WML\* loses 26.7% against the paper's 9.6%.

## Volatility-managed strategy (V-WML)
The paper does not give the exact V-WML scheme. This replication uses a Barroso–Santa-Clara style rule: weight = 12% / (annualised standard deviation of the previous 126 daily WML returns), no cap. **This is an assumption**, chosen because it is the standard construction. With it V-WML lands close to the paper's moments (mean 1.27 vs 1.24, sd 4.70 vs 4.65, min −19.07 vs −19.36, Sharpe 0.270 vs 0.266). V-WML still earns a negative average return in rebound months (−1.51%, t = −3.85).

## Out of sample (Apr 2022 – Dec 2024, 33 months)
Monthly Sharpe ratios:

| Adjustment | WML\* | V-WML | WML |
|---|---|---|---|
| Market-adjusted | **0.321** | 0.241 | 0.231 |
| CAPM | **0.293** | 0.239 | 0.248 |
| Fama–French 3-factor | **0.306** | 0.225 | 0.228 |

WML\* has the highest Sharpe ratio in all three. The window is 33 months because the monthly CRSP file used here ends in Dec 2024. A 33-month sample is short, so these Sharpe ratios carry wide error bands.

## Data notes
- **Universe:** ordinary common stock only (share codes 10/11) on NYSE, AMEX and NASDAQ, from legacy CRSP monthly data with delisting returns compounded in.
- **Daily extract:** the daily CRSP file contains 21,399 duplicated stock-dates (3,767 stocks, 8 to 343 copies each). One row per stock-date is kept. Details in `results/sanity_report.md`.
- **Adjusted returns:** CAPM and FF betas are estimated ex ante on the previous 36 months, as in the paper, not inside the rebound subsample.
- **Spread labels:** all long-short spreads are decile 10 − decile 1.

## Known gaps
- **Stocks per month:** 2,334 vs the paper's 2,222 (+5.05%). Unexplained; the paper gives no breakdown by period.
- **WML\* tails:** kurtosis 7.7 vs 4.5, minimum −26.7 vs −23.7, and the Jul 1932 loss above.
- **Table 3:** average Nearhigh and Momentum of the portfolios are 1–2 points off.
- **Table 8:** Amihud is a monthly approximation (the extract has no daily volume), so it does not match. NASDAQ volume is missing for 30% of the 1970s and 12% of the 1980s stock-months, so share turnover there rests on partial coverage. WML\* market caps and spreads are 0.05–0.2 off.
- **Table 6:** the market-illiquidity and macro-variable models are not computed (they need daily volume and Chordia–Shivakumar macro data).
- **V-WML** uses an assumed scheme (above).
- **Fama–MacBeth** regressions are not included.

## Method
| Step | What is done (the paper's rules) |
|---|---|
| Universe | Common stock on NYSE/AMEX/NASDAQ; price ≥ $5 at formation; valid shares, price, return, Momentum and Nearhigh. Portfolio returns Jan 1930 – Mar 2022 in sample |
| Momentum | Cumulative return of months t−11 to t−1 (skip month t); at least 8 valid months. Delisting returns compounded; Shumway −30% where a performance delisting has no return |
| Nearhigh | Month-end price ÷ highest daily close over months t−11 to t, from a split-adjusted index built from daily returns |
| Portfolios | Deciles of equal stock counts, value-weighted at formation, held one month. WML = decile 10 − decile 1 |
| WML\* | 5 Nearhigh quintiles × 10 Momentum deciles (50 value-weighted portfolios); equal-weight the five portfolios in each Momentum decile |
| Rebound month | CRSP value-weighted market return > 0 and the previous 12 months' cumulative market return < 0 (157 of 1,107 months) |
| Adjustment | Market-adjusted (minus market), CAPM and FF3 with rolling past-36-month betas; rebound averages by regression on state dummies with White standard errors |
| V-WML | See above (assumption) |

Tables produced: 1 (univariate sorts), 2 (bivariate), 3 (WML\* detail), 5 (rebound averages), 6 (time variation, partial), 7 (moments, in sample and out of sample), 8 (trading frictions), A1 (ten largest crash months), A4 (subperiods).

## Data (not included)
CRSP data is licensed through WRDS and is not in this repo (`.gitignore` blocks it).

| File | Source |
|---|---|
| `crsp_monthly_new.csv` | WRDS, CRSP legacy Monthly Stock File, Dec 1925 – Dec 2024, share codes 10/11, exchange codes 1/2/3, with delisting variables |
| `crsp_daily(all).csv` | WRDS, CRSP CIZ daily: permno, dlycaldt, dlyclose, dlyhigh, dlylow, dlyret. About 9 GB; contains the duplicated rows described above |
| `FF3_MOM.csv`, `FF3_MOM-Daily.csv` | Ken French data library (monthly and daily) |

## Run it
```r
install.packages(c("data.table","tidyverse","lubridate","moments","sandwich","lmtest"))
Rscript momentum_crashes_replication.R                  # data build and checkpoints, then stops
RUN_TABLES=1 Rscript momentum_crashes_replication.R     # also builds all tables
```
The run caches intermediate files in `results/cache/` (about 1.5 GB, CRSP-derived, not committed) and used up to about 11 GB of memory in the logged run.

## Results folder
`results/` holds the table CSVs, `sanity_report.md` (checkpoints, data notes, assumptions), `comparison_paper_vs_replication.md/.csv`, `coverage_by_decade.csv` and `daily_duplicate_copies_summary.csv`.

## Reference
Byun, S. J., & Jeon, B. (2023). Momentum Crashes and the 52-Week High. *Financial Analysts Journal*, 79(2), 120–139. Daniel, K., & Moskowitz, T. (2016). Momentum crashes. *Journal of Financial Economics*, 122(2), 221–247. Barroso, P., & Santa-Clara, P. (2015). Momentum has its moments. *Journal of Financial Economics*, 116(1), 111–120.

Author: Akshay Rao.
