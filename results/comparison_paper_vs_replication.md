# Paper vs replication

Paper: Byun & Jeon (2023), FAJ 79(2). Replication: `momentum_crashes_replication.R` (outputs in `results/`).

**Status rules** (difference = replication − paper): percent-unit statistics: match ≤0.05, small gap ≤0.5, else large gap; shape statistics (skew, kurtosis, Table 8): match ≤0.05, small ≤0.25; Sharpe: match ≤0.005, small ≤0.03; sign flips >0.5 count as large gaps; 'not comparable' = no paper counterpart or not computed. Paper Table 7/A4 decimals are ×100 (% per month).

## Status counts

| status | rows |
|---|---|
| match | 183 |
| small gap | 117 |
| large gap | 78 |
| not comparable | 36 |

## Per table

| table | match | small gap | large gap | not comparable |
|---|---|---|---|---|
| Table 1 | 96 | 36 | 0 | 0 |
| Table 2 | 13 | 7 | 0 | 0 |
| Table 3 | 14 | 7 | 9 | 0 |
| Table 5 (rebound avg) | 3 | 1 | 0 | 2 |
| Table 6 (extra) | 6 | 4 | 2 | 1 |
| Table 7 (in-sample) | 25 | 17 | 21 | 0 |
| OOS Apr2022-Dec2024 (33 mo.) | 0 | 0 | 0 | 27 |
| Table 8 | 11 | 6 | 3 | 0 |
| Table A1 | 4 | 20 | 43 | 1 |
| Table A4 | 11 | 19 | 0 | 0 |
| Table A4 (V-WML, no paper row) | 0 | 0 | 0 | 5 |

## Table 1

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| A1. Market Rebounds MAR D1 | 3.42 | Paper Table 1 panel A1, p.123 | 3.45 | 0.03 | match |  |
| A1. Market Rebounds MAR D2 | 2.36 | Paper Table 1 panel A1, p.123 | 2.43 | 0.07 | small gap |  |
| A1. Market Rebounds MAR D3 | 1.43 | Paper Table 1 panel A1, p.123 | 1.33 | -0.1 | small gap |  |
| A1. Market Rebounds MAR D4 | 0.82 | Paper Table 1 panel A1, p.123 | 0.85 | 0.03 | match |  |
| A1. Market Rebounds MAR D5 | 0.32 | Paper Table 1 panel A1, p.123 | 0.32 | 0.0 | match |  |
| A1. Market Rebounds MAR D6 | -0.29 | Paper Table 1 panel A1, p.123 | -0.31 | -0.02 | match |  |
| A1. Market Rebounds MAR D7 | -0.63 | Paper Table 1 panel A1, p.123 | -0.62 | 0.01 | match |  |
| A1. Market Rebounds MAR D8 | -0.96 | Paper Table 1 panel A1, p.123 | -0.99 | -0.03 | match |  |
| A1. Market Rebounds MAR D9 | -0.7 | Paper Table 1 panel A1, p.123 | -0.7 | 0.0 | match |  |
| A1. Market Rebounds MAR D10 | -0.71 | Paper Table 1 panel A1, p.123 | -0.73 | -0.02 | match |  |
| A1. Market Rebounds MAR D10-D1 | -4.13 | Paper Table 1 panel A1, p.123 | -4.17 | -0.04 | match |  |
| A1. Market Rebounds CAPM D1 | 1.07 | Paper Table 1 panel A1, p.123 | 1.07 | 0.0 | match |  |
| A1. Market Rebounds CAPM D2 | 1.13 | Paper Table 1 panel A1, p.123 | 1.23 | 0.1 | small gap |  |
| A1. Market Rebounds CAPM D3 | 1.05 | Paper Table 1 panel A1, p.123 | 0.94 | -0.11 | small gap |  |
| A1. Market Rebounds CAPM D4 | 0.68 | Paper Table 1 panel A1, p.123 | 0.73 | 0.05 | match |  |
| A1. Market Rebounds CAPM D5 | 0.5 | Paper Table 1 panel A1, p.123 | 0.51 | 0.01 | match |  |
| A1. Market Rebounds CAPM D6 | -0.03 | Paper Table 1 panel A1, p.123 | -0.02 | 0.01 | match |  |
| A1. Market Rebounds CAPM D7 | -0.35 | Paper Table 1 panel A1, p.123 | -0.33 | 0.02 | match |  |
| A1. Market Rebounds CAPM D8 | -0.59 | Paper Table 1 panel A1, p.123 | -0.63 | -0.04 | match |  |
| A1. Market Rebounds CAPM D9 | -0.74 | Paper Table 1 panel A1, p.123 | -0.71 | 0.03 | match |  |
| A1. Market Rebounds CAPM D10 | -1.18 | Paper Table 1 panel A1, p.123 | -1.19 | -0.01 | match |  |
| A1. Market Rebounds CAPM D10-D1 | -2.26 | Paper Table 1 panel A1, p.123 | -2.25 | 0.01 | match |  |
| A1. Market Rebounds FF D1 | 0.92 | Paper Table 1 panel A1, p.123 | 0.97 | 0.05 | match |  |
| A1. Market Rebounds FF D2 | 0.97 | Paper Table 1 panel A1, p.123 | 1.02 | 0.05 | match |  |
| A1. Market Rebounds FF D3 | 0.76 | Paper Table 1 panel A1, p.123 | 0.73 | -0.03 | match |  |
| A1. Market Rebounds FF D4 | 0.56 | Paper Table 1 panel A1, p.123 | 0.59 | 0.03 | match |  |
| A1. Market Rebounds FF D5 | 0.27 | Paper Table 1 panel A1, p.123 | 0.28 | 0.01 | match |  |
| A1. Market Rebounds FF D6 | -0.1 | Paper Table 1 panel A1, p.123 | -0.13 | -0.03 | match |  |
| A1. Market Rebounds FF D7 | -0.49 | Paper Table 1 panel A1, p.123 | -0.45 | 0.04 | match |  |
| A1. Market Rebounds FF D8 | -0.6 | Paper Table 1 panel A1, p.123 | -0.61 | -0.01 | match |  |
| A1. Market Rebounds FF D9 | -0.71 | Paper Table 1 panel A1, p.123 | -0.7 | 0.01 | match |  |
| A1. Market Rebounds FF D10 | -1.02 | Paper Table 1 panel A1, p.123 | -1.04 | -0.02 | match |  |
| A1. Market Rebounds FF D10-D1 | -1.94 | Paper Table 1 panel A1, p.123 | -2.01 | -0.07 | small gap |  |
| A2. Non-Rebounds MAR D1 | -1.26 | Paper Table 1 panel A2, p.123 | -1.25 | 0.01 | match |  |
| A2. Non-Rebounds MAR D2 | -0.81 | Paper Table 1 panel A2, p.123 | -0.8 | 0.01 | match |  |
| A2. Non-Rebounds MAR D3 | -0.41 | Paper Table 1 panel A2, p.123 | -0.4 | 0.01 | match |  |
| A2. Non-Rebounds MAR D4 | -0.25 | Paper Table 1 panel A2, p.123 | -0.23 | 0.02 | match |  |
| A2. Non-Rebounds MAR D5 | -0.12 | Paper Table 1 panel A2, p.123 | -0.12 | 0.0 | match |  |
| A2. Non-Rebounds MAR D6 | 0.03 | Paper Table 1 panel A2, p.123 | 0.05 | 0.02 | match |  |
| A2. Non-Rebounds MAR D7 | 0.21 | Paper Table 1 panel A2, p.123 | 0.23 | 0.02 | match |  |
| A2. Non-Rebounds MAR D8 | 0.35 | Paper Table 1 panel A2, p.123 | 0.37 | 0.02 | match |  |
| A2. Non-Rebounds MAR D9 | 0.44 | Paper Table 1 panel A2, p.123 | 0.45 | 0.01 | match |  |
| A2. Non-Rebounds MAR D10 | 0.82 | Paper Table 1 panel A2, p.123 | 0.86 | 0.04 | match |  |
| A2. Non-Rebounds MAR D10-D1 | 2.07 | Paper Table 1 panel A2, p.123 | 2.11 | 0.04 | match |  |
| A2. Non-Rebounds CAPM D1 | -1.18 | Paper Table 1 panel A2, p.123 | -1.18 | 0.0 | match |  |
| A2. Non-Rebounds CAPM D2 | -0.74 | Paper Table 1 panel A2, p.123 | -0.75 | -0.01 | match |  |
| A2. Non-Rebounds CAPM D3 | -0.39 | Paper Table 1 panel A2, p.123 | -0.4 | -0.01 | match |  |
| A2. Non-Rebounds CAPM D4 | -0.23 | Paper Table 1 panel A2, p.123 | -0.22 | 0.01 | match |  |
| A2. Non-Rebounds CAPM D5 | -0.14 | Paper Table 1 panel A2, p.123 | -0.16 | -0.02 | match |  |
| A2. Non-Rebounds CAPM D6 | 0.01 | Paper Table 1 panel A2, p.123 | 0.01 | 0.0 | match |  |
| A2. Non-Rebounds CAPM D7 | 0.18 | Paper Table 1 panel A2, p.123 | 0.19 | 0.01 | match |  |
| A2. Non-Rebounds CAPM D8 | 0.31 | Paper Table 1 panel A2, p.123 | 0.31 | 0.0 | match |  |
| A2. Non-Rebounds CAPM D9 | 0.45 | Paper Table 1 panel A2, p.123 | 0.43 | -0.02 | match |  |
| A2. Non-Rebounds CAPM D10 | 0.83 | Paper Table 1 panel A2, p.123 | 0.85 | 0.02 | match |  |
| A2. Non-Rebounds CAPM D10-D1 | 2.0 | Paper Table 1 panel A2, p.123 | 2.03 | 0.03 | match |  |
| A2. Non-Rebounds FF D1 | -1.15 | Paper Table 1 panel A2, p.123 | -1.16 | -0.01 | match |  |
| A2. Non-Rebounds FF D2 | -0.76 | Paper Table 1 panel A2, p.123 | -0.79 | -0.03 | match |  |
| A2. Non-Rebounds FF D3 | -0.41 | Paper Table 1 panel A2, p.123 | -0.41 | 0.0 | match |  |
| A2. Non-Rebounds FF D4 | -0.24 | Paper Table 1 panel A2, p.123 | -0.24 | 0.0 | match |  |
| A2. Non-Rebounds FF D5 | -0.16 | Paper Table 1 panel A2, p.123 | -0.18 | -0.02 | match |  |
| A2. Non-Rebounds FF D6 | 0.0 | Paper Table 1 panel A2, p.123 | -0.0 | -0.0 | match |  |
| A2. Non-Rebounds FF D7 | 0.18 | Paper Table 1 panel A2, p.123 | 0.19 | 0.01 | match |  |
| A2. Non-Rebounds FF D8 | 0.31 | Paper Table 1 panel A2, p.123 | 0.31 | 0.0 | match |  |
| A2. Non-Rebounds FF D9 | 0.45 | Paper Table 1 panel A2, p.123 | 0.43 | -0.02 | match |  |
| A2. Non-Rebounds FF D10 | 0.84 | Paper Table 1 panel A2, p.123 | 0.88 | 0.04 | match |  |
| A2. Non-Rebounds FF D10-D1 | 1.99 | Paper Table 1 panel A2, p.123 | 2.04 | 0.05 | match |  |
| B1. Market Rebounds MAR D1 | 4.81 | Paper Table 1 panel B1, p.123 | 4.92 | 0.11 | small gap |  |
| B1. Market Rebounds MAR D2 | 3.41 | Paper Table 1 panel B1, p.123 | 3.44 | 0.03 | match |  |
| B1. Market Rebounds MAR D3 | 2.54 | Paper Table 1 panel B1, p.123 | 2.43 | -0.11 | small gap |  |
| B1. Market Rebounds MAR D4 | 1.63 | Paper Table 1 panel B1, p.123 | 1.69 | 0.06 | small gap |  |
| B1. Market Rebounds MAR D5 | 0.79 | Paper Table 1 panel B1, p.123 | 0.95 | 0.16 | small gap |  |
| B1. Market Rebounds MAR D6 | 0.23 | Paper Table 1 panel B1, p.123 | 0.09 | -0.14 | small gap |  |
| B1. Market Rebounds MAR D7 | -0.44 | Paper Table 1 panel B1, p.123 | -0.43 | 0.01 | match |  |
| B1. Market Rebounds MAR D8 | -0.72 | Paper Table 1 panel B1, p.123 | -0.78 | -0.06 | small gap |  |
| B1. Market Rebounds MAR D9 | -1.42 | Paper Table 1 panel B1, p.123 | -1.56 | -0.14 | small gap |  |
| B1. Market Rebounds MAR D10 | -2.11 | Paper Table 1 panel B1, p.123 | -2.21 | -0.1 | small gap |  |
| B1. Market Rebounds MAR D10-D1 | -6.91 | Paper Table 1 panel B1, p.123 | -7.13 | -0.22 | small gap |  |
| B1. Market Rebounds CAPM D1 | 1.45 | Paper Table 1 panel B1, p.123 | 1.4 | -0.05 | match |  |
| B1. Market Rebounds CAPM D2 | 1.04 | Paper Table 1 panel B1, p.123 | 1.03 | -0.01 | match |  |
| B1. Market Rebounds CAPM D3 | 1.23 | Paper Table 1 panel B1, p.123 | 1.09 | -0.14 | small gap |  |
| B1. Market Rebounds CAPM D4 | 0.76 | Paper Table 1 panel B1, p.123 | 0.71 | -0.05 | match |  |
| B1. Market Rebounds CAPM D5 | 0.41 | Paper Table 1 panel B1, p.123 | 0.53 | 0.12 | small gap |  |
| B1. Market Rebounds CAPM D6 | 0.1 | Paper Table 1 panel B1, p.123 | -0.04 | -0.14 | small gap |  |
| B1. Market Rebounds CAPM D7 | -0.22 | Paper Table 1 panel B1, p.123 | -0.16 | 0.06 | small gap |  |
| B1. Market Rebounds CAPM D8 | -0.25 | Paper Table 1 panel B1, p.123 | -0.3 | -0.05 | match |  |
| B1. Market Rebounds CAPM D9 | -0.65 | Paper Table 1 panel B1, p.123 | -0.69 | -0.04 | match |  |
| B1. Market Rebounds CAPM D10 | -0.84 | Paper Table 1 panel B1, p.123 | -0.91 | -0.07 | small gap |  |
| B1. Market Rebounds CAPM D10-D1 | -2.28 | Paper Table 1 panel B1, p.123 | -2.49 | -0.21 | small gap |  |
| B1. Market Rebounds FF D1 | 1.25 | Paper Table 1 panel B1, p.123 | 1.18 | -0.07 | small gap |  |
| B1. Market Rebounds FF D2 | 0.93 | Paper Table 1 panel B1, p.123 | 0.93 | 0.0 | match |  |
| B1. Market Rebounds FF D3 | 1.05 | Paper Table 1 panel B1, p.123 | 0.95 | -0.1 | small gap |  |
| B1. Market Rebounds FF D4 | 0.68 | Paper Table 1 panel B1, p.123 | 0.64 | -0.04 | match |  |
| B1. Market Rebounds FF D5 | 0.39 | Paper Table 1 panel B1, p.123 | 0.55 | 0.16 | small gap |  |
| B1. Market Rebounds FF D6 | 0.05 | Paper Table 1 panel B1, p.123 | -0.13 | -0.18 | small gap |  |
| B1. Market Rebounds FF D7 | -0.18 | Paper Table 1 panel B1, p.123 | -0.12 | 0.06 | small gap |  |
| B1. Market Rebounds FF D8 | -0.31 | Paper Table 1 panel B1, p.123 | -0.3 | 0.01 | match |  |
| B1. Market Rebounds FF D9 | -0.66 | Paper Table 1 panel B1, p.123 | -0.76 | -0.1 | small gap |  |
| B1. Market Rebounds FF D10 | -0.78 | Paper Table 1 panel B1, p.123 | -0.93 | -0.15 | small gap |  |
| B1. Market Rebounds FF D10-D1 | -2.03 | Paper Table 1 panel B1, p.123 | -2.26 | -0.23 | small gap |  |
| B2. Non-Rebounds MAR D1 | -1.04 | Paper Table 1 panel B2, p.123 | -1.05 | -0.01 | match |  |
| B2. Non-Rebounds MAR D2 | -0.66 | Paper Table 1 panel B2, p.123 | -0.68 | -0.02 | match |  |
| B2. Non-Rebounds MAR D3 | -0.27 | Paper Table 1 panel B2, p.123 | -0.27 | 0.0 | match |  |
| B2. Non-Rebounds MAR D4 | -0.25 | Paper Table 1 panel B2, p.123 | -0.22 | 0.03 | match |  |
| B2. Non-Rebounds MAR D5 | -0.12 | Paper Table 1 panel B2, p.123 | -0.05 | 0.07 | small gap |  |
| B2. Non-Rebounds MAR D6 | -0.06 | Paper Table 1 panel B2, p.123 | 0.01 | 0.07 | small gap |  |
| B2. Non-Rebounds MAR D7 | 0.01 | Paper Table 1 panel B2, p.123 | -0.01 | -0.02 | match |  |
| B2. Non-Rebounds MAR D8 | 0.18 | Paper Table 1 panel B2, p.123 | 0.2 | 0.02 | match |  |
| B2. Non-Rebounds MAR D9 | 0.34 | Paper Table 1 panel B2, p.123 | 0.3 | -0.04 | match |  |
| B2. Non-Rebounds MAR D10 | 0.18 | Paper Table 1 panel B2, p.123 | 0.22 | 0.04 | match |  |
| B2. Non-Rebounds MAR D10-D1 | 1.23 | Paper Table 1 panel B2, p.123 | 1.32 | 0.09 | small gap |  |
| B2. Non-Rebounds CAPM D1 | -0.94 | Paper Table 1 panel B2, p.123 | -0.95 | -0.01 | match |  |
| B2. Non-Rebounds CAPM D2 | -0.54 | Paper Table 1 panel B2, p.123 | -0.58 | -0.04 | match |  |
| B2. Non-Rebounds CAPM D3 | -0.23 | Paper Table 1 panel B2, p.123 | -0.26 | -0.03 | match |  |
| B2. Non-Rebounds CAPM D4 | -0.22 | Paper Table 1 panel B2, p.123 | -0.2 | 0.02 | match |  |
| B2. Non-Rebounds CAPM D5 | -0.12 | Paper Table 1 panel B2, p.123 | -0.07 | 0.05 | match |  |
| B2. Non-Rebounds CAPM D6 | -0.07 | Paper Table 1 panel B2, p.123 | -0.01 | 0.06 | small gap |  |
| B2. Non-Rebounds CAPM D7 | -0.01 | Paper Table 1 panel B2, p.123 | -0.06 | -0.05 | match |  |
| B2. Non-Rebounds CAPM D8 | 0.18 | Paper Table 1 panel B2, p.123 | 0.19 | 0.01 | match |  |
| B2. Non-Rebounds CAPM D9 | 0.33 | Paper Table 1 panel B2, p.123 | 0.27 | -0.06 | small gap |  |
| B2. Non-Rebounds CAPM D10 | 0.17 | Paper Table 1 panel B2, p.123 | 0.14 | -0.03 | match |  |
| B2. Non-Rebounds CAPM D10-D1 | 1.11 | Paper Table 1 panel B2, p.123 | 1.12 | 0.01 | match |  |
| B2. Non-Rebounds FF D1 | -0.91 | Paper Table 1 panel B2, p.123 | -0.91 | 0.0 | match |  |
| B2. Non-Rebounds FF D2 | -0.53 | Paper Table 1 panel B2, p.123 | -0.55 | -0.02 | match |  |
| B2. Non-Rebounds FF D3 | -0.27 | Paper Table 1 panel B2, p.123 | -0.3 | -0.03 | match |  |
| B2. Non-Rebounds FF D4 | -0.29 | Paper Table 1 panel B2, p.123 | -0.26 | 0.03 | match |  |
| B2. Non-Rebounds FF D5 | -0.15 | Paper Table 1 panel B2, p.123 | -0.11 | 0.04 | match |  |
| B2. Non-Rebounds FF D6 | -0.06 | Paper Table 1 panel B2, p.123 | -0.01 | 0.05 | match |  |
| B2. Non-Rebounds FF D7 | -0.02 | Paper Table 1 panel B2, p.123 | -0.09 | -0.07 | small gap |  |
| B2. Non-Rebounds FF D8 | 0.17 | Paper Table 1 panel B2, p.123 | 0.18 | 0.01 | match |  |
| B2. Non-Rebounds FF D9 | 0.34 | Paper Table 1 panel B2, p.123 | 0.27 | -0.07 | small gap |  |
| B2. Non-Rebounds FF D10 | 0.13 | Paper Table 1 panel B2, p.123 | 0.16 | 0.03 | match |  |
| B2. Non-Rebounds FF D10-D1 | 1.04 | Paper Table 1 panel B2, p.123 | 1.11 | 0.07 | small gap |  |

## Table 2

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| A3 rebound, Mom 5-1 within NH quintile, quintile 1 | -0.04 | Paper Table 2, p.125 | -0.01 | 0.03 | match |  |
| A3 rebound, Mom 5-1 within NH quintile, quintile 2 | 0.9 | Paper Table 2, p.125 | 0.93 | 0.03 | match |  |
| A3 rebound, Mom 5-1 within NH quintile, quintile 3 | 1.38 | Paper Table 2, p.125 | 1.29 | -0.09 | small gap |  |
| A3 rebound, Mom 5-1 within NH quintile, quintile 4 | 1.5 | Paper Table 2, p.125 | 1.14 | -0.36 | small gap |  |
| A3 rebound, Mom 5-1 within NH quintile, quintile 5 | 0.49 | Paper Table 2, p.125 | 0.45 | -0.04 | match |  |
| A4 non-rebound, Mom 5-1 within NH quintile, quintile 1 | 1.58 | Paper Table 2, p.125 | 1.55 | -0.03 | match |  |
| A4 non-rebound, Mom 5-1 within NH quintile, quintile 2 | 0.97 | Paper Table 2, p.125 | 0.94 | -0.03 | match |  |
| A4 non-rebound, Mom 5-1 within NH quintile, quintile 3 | 1.04 | Paper Table 2, p.125 | 1.09 | 0.05 | match |  |
| A4 non-rebound, Mom 5-1 within NH quintile, quintile 4 | 0.84 | Paper Table 2, p.125 | 0.8 | -0.04 | match |  |
| A4 non-rebound, Mom 5-1 within NH quintile, quintile 5 | 0.87 | Paper Table 2, p.125 | 0.86 | -0.01 | match |  |
| B1 rebound, NH 5-1 within Mom quintile, quintile 1 | -4.98 | Paper Table 2, p.125 | -5.01 | -0.03 | match |  |
| B1 rebound, NH 5-1 within Mom quintile, quintile 2 | -4.65 | Paper Table 2, p.125 | -4.67 | -0.02 | match |  |
| B1 rebound, NH 5-1 within Mom quintile, quintile 3 | -4.23 | Paper Table 2, p.125 | -4.43 | -0.2 | small gap |  |
| B1 rebound, NH 5-1 within Mom quintile, quintile 4 | -3.36 | Paper Table 2, p.125 | -3.6 | -0.24 | small gap |  |
| B1 rebound, NH 5-1 within Mom quintile, quintile 5 | -3.83 | Paper Table 2, p.125 | -3.43 | 0.4 | small gap |  |
| B2 non-rebound, NH 5-1 within Mom quintile, quintile 1 | 0.52 | Paper Table 2, p.125 | 0.62 | 0.1 | small gap |  |
| B2 non-rebound, NH 5-1 within Mom quintile, quintile 2 | -0.09 | Paper Table 2, p.125 | 0.11 | 0.2 | small gap |  |
| B2 non-rebound, NH 5-1 within Mom quintile, quintile 3 | 0.0 | Paper Table 2, p.125 | 0.03 | 0.03 | match |  |
| B2 non-rebound, NH 5-1 within Mom quintile, quintile 4 | 0.1 | Paper Table 2, p.125 | 0.11 | 0.01 | match |  |
| B2 non-rebound, NH 5-1 within Mom quintile, quintile 5 | 0.3 | Paper Table 2, p.125 | 0.27 | -0.03 | match |  |

## Table 3

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| A. Market Rebounds Nearhigh D1 | 65.75 | Paper Table 3, p.126 | 67.4 | 1.65 | large gap |  |
| A. Market Rebounds Nearhigh D10 | 71.24 | Paper Table 3, p.126 | 72.88 | 1.64 | large gap |  |
| A. Market Rebounds Nearhigh WML* (D10*-D1*) | 5.49 | Paper Table 3, p.126 | 5.47 | -0.02 | match |  |
| A. Market Rebounds Momentum D1 | -34.86 | Paper Table 3, p.126 | -34.87 | -0.01 | match |  |
| A. Market Rebounds Momentum D10 | 42.84 | Paper Table 3, p.126 | 44.17 | 1.33 | large gap |  |
| A. Market Rebounds Momentum WML* (D10*-D1*) | 77.7 | Paper Table 3, p.126 | 79.04 | 1.34 | large gap |  |
| A. Market Rebounds MAR D1 | 0.36 | Paper Table 3, p.126 | 0.45 | 0.09 | small gap |  |
| A. Market Rebounds MAR D10 | 1.63 | Paper Table 3, p.126 | 1.6 | -0.03 | match |  |
| A. Market Rebounds MAR WML* (D10*-D1*) | 1.27 | Paper Table 3, p.126 | 1.15 | -0.12 | small gap |  |
| A. Market Rebounds CAPM D1 | -0.07 | Paper Table 3, p.126 | 0.05 | 0.12 | small gap |  |
| A. Market Rebounds CAPM D10 | -0.08 | Paper Table 3, p.126 | -0.08 | 0.0 | match |  |
| A. Market Rebounds CAPM WML* (D10*-D1*) | -0.01 | Paper Table 3, p.126 | -0.13 | -0.12 | small gap |  |
| A. Market Rebounds FF D1 | -0.3 | Paper Table 3, p.126 | -0.23 | 0.07 | small gap |  |
| A. Market Rebounds FF D10 | -0.13 | Paper Table 3, p.126 | -0.08 | 0.05 | match |  |
| A. Market Rebounds FF WML* (D10*-D1*) | 0.18 | Paper Table 3, p.126 | 0.15 | -0.03 | match |  |
| B. Non-Rebounds Nearhigh D1 | 78.93 | Paper Table 3, p.126 | 79.95 | 1.02 | large gap |  |
| B. Non-Rebounds Nearhigh D10 | 83.04 | Paper Table 3, p.126 | 84.04 | 1.0 | large gap |  |
| B. Non-Rebounds Nearhigh WML* (D10*-D1*) | 4.11 | Paper Table 3, p.126 | 4.09 | -0.02 | match |  |
| B. Non-Rebounds Momentum D1 | -17.71 | Paper Table 3, p.126 | -18.06 | -0.35 | large gap |  |
| B. Non-Rebounds Momentum D10 | 123.0 | Paper Table 3, p.126 | 123.96 | 0.96 | large gap |  |
| B. Non-Rebounds Momentum WML* (D10*-D1*) | 140.71 | Paper Table 3, p.126 | 142.02 | 1.31 | large gap |  |
| B. Non-Rebounds MAR D1 | -0.9 | Paper Table 3, p.126 | -0.88 | 0.02 | match |  |
| B. Non-Rebounds MAR D10 | 0.5 | Paper Table 3, p.126 | 0.54 | 0.04 | match |  |
| B. Non-Rebounds MAR WML* (D10*-D1*) | 1.39 | Paper Table 3, p.126 | 1.42 | 0.03 | match |  |
| B. Non-Rebounds CAPM D1 | -0.88 | Paper Table 3, p.126 | -0.9 | -0.02 | match |  |
| B. Non-Rebounds CAPM D10 | 0.55 | Paper Table 3, p.126 | 0.59 | 0.04 | match |  |
| B. Non-Rebounds CAPM WML* (D10*-D1*) | 1.43 | Paper Table 3, p.126 | 1.49 | 0.06 | small gap |  |
| B. Non-Rebounds FF D1 | -0.9 | Paper Table 3, p.126 | -0.92 | -0.02 | match |  |
| B. Non-Rebounds FF D10 | 0.54 | Paper Table 3, p.126 | 0.58 | 0.04 | match |  |
| B. Non-Rebounds FF WML* (D10*-D1*) | 1.44 | Paper Table 3, p.126 | 1.5 | 0.06 | small gap |  |

## Table 5 (rebound avg)

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| WML All CRSP, rebound avg (t=-4.56) | -4.13 | Paper Table 1 A1/A2 MAR 10-1, p.123 | -4.174 | -0.044 | match |  |
| WML All CRSP, non-rebound avg (t=10.56) | 2.07 | Paper Table 1 A1/A2 MAR 10-1, p.123 | 2.11 | 0.04 | match |  |
| WML* All CRSP, rebound avg (t=2.57) | 1.27 | Paper Table 3 A2/B2 WML* MAR, p.126 | 1.149 | -0.121 | small gap |  |
| WML* All CRSP, non-rebound avg (t=8.95) | 1.39 | Paper Table 3 A2/B2 WML* MAR, p.126 | 1.42 | 0.03 | match |  |
| V-WML All CRSP, rebound avg (t=-3.85) |  | no paper counterpart | -1.513 |  | not comparable |  |
| V-WML All CRSP, non-rebound avg (t=11.83) |  | no paper counterpart | 1.728 |  | not comparable |  |

## Table 6 (extra)

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| WML model 1 (Intercept) | 1.15 | Paper Table 6, p.130 (x100) | 1.16 | 0.01 | match | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML model 1 Mktret | 4.6 | Paper Table 6, p.130 (x100) | 4.8500000000000005 | 0.25 | small gap | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML model 1 Mktret2 | -8.59 | Paper Table 6, p.130 (x100) | -8.799999999999999 | -0.21 | small gap | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML model 2 (Intercept) | 1.72 | Paper Table 6, p.130 (x100) | 1.7999999999999998 | 0.08 | small gap | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML model 3 (Intercept) | 1.4500000000000002 | Paper Table 6, p.130 (x100) | 1.47 | 0.02 | match | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML model 3 I_Jan | -3.04 | Paper Table 6, p.130 (x100) | -3.02 | 0.02 | match | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML* model 6 (Intercept) | 1.5 | Paper Table 6, p.130 (x100) | 1.46 | -0.04 | match | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML* model 6 Mktret | -0.79 | Paper Table 6, p.130 (x100) | 0.15 | 0.94 | large gap | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML* model 6 Mktret2 | -0.6 | Paper Table 6, p.130 (x100) | -1.6 | -1.0 | large gap | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML* model 7 (Intercept) | 1.29 | Paper Table 6, p.130 (x100) | 1.31 | 0.02 | match | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML* model 8 (Intercept) | 1.37 | Paper Table 6, p.130 (x100) | 1.39 | 0.02 | match | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML* model 8 I_Jan | 0.05 | Paper Table 6, p.130 (x100) | -0.08 | -0.13 | small gap | paper models 3->ours 2 (Mktvol), 4->ours 3 (Jan), 8->ours 7, 9->ours 8; coefficients x100 |
| WML Mktvol coefficient | -0.1847 | Paper Table 6 (3), p.130 | -51.264 | -51.0793 | not comparable | Mktvol scale differs (ours: variance of 126 daily returns; paper's scaling not stated); signs agree (negative) |

## Table 7 (in-sample)

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| WML Average [MAR] | 1.19 | Paper Table 7 Panel A, p.131 | 1.2189 | 0.0289 | match |  |
| WML Std Dev [MAR] | 7.51 | Paper Table 7 Panel A, p.131 | 7.4863 | -0.0237 | match |  |
| WML Skew [MAR] | -1.8903 | Paper Table 7 Panel A, p.131 | -1.896 | -0.0057 | match |  |
| WML Kurt [MAR] | 17.3762 | Paper Table 7 Panel A, p.131 | 20.4174 | 3.0412 | large gap |  |
| WML Min [MAR] | -74.06 | Paper Table 7 Panel A, p.131 | -73.819 | 0.241 | small gap |  |
| WML Max [MAR] | 42.01 | Paper Table 7 Panel A, p.131 | 40.3609 | -1.6491 | large gap |  |
| WML Sharpe [MAR] | 0.1585 | Paper Table 7 Panel A, p.131 | 0.1628 | 0.0043 | match |  |
| WML* Average [MAR] | 1.37 | Paper Table 7 Panel A, p.131 | 1.3815 | 0.0115 | match |  |
| WML* Std Dev [MAR] | 4.96 | Paper Table 7 Panel A, p.131 | 4.9981 | 0.0381 | match |  |
| WML* Skew [MAR] | 0.1258 | Paper Table 7 Panel A, p.131 | 0.0409 | -0.0849 | small gap |  |
| WML* Kurt [MAR] | 4.4772 | Paper Table 7 Panel A, p.131 | 7.7147 | 3.2375 | large gap |  |
| WML* Min [MAR] | -23.66 | Paper Table 7 Panel A, p.131 | -26.7064 | -3.0464 | large gap |  |
| WML* Max [MAR] | 36.16 | Paper Table 7 Panel A, p.131 | 33.6115 | -2.5485 | large gap |  |
| WML* Sharpe [MAR] | 0.2762 | Paper Table 7 Panel A, p.131 | 0.2764 | 0.0002 | match |  |
| V-WML Average [MAR] | 1.24 | Paper Table 7 Panel A, p.131 | 1.2686 | 0.0286 | match |  |
| V-WML Std Dev [MAR] | 4.65 | Paper Table 7 Panel A, p.131 | 4.7036 | 0.0536 | small gap |  |
| V-WML Skew [MAR] | -0.1251 | Paper Table 7 Panel A, p.131 | -0.131 | -0.0059 | match |  |
| V-WML Kurt [MAR] | 1.5593 | Paper Table 7 Panel A, p.131 | 4.5821 | 3.0228 | large gap |  |
| V-WML Min [MAR] | -19.36 | Paper Table 7 Panel A, p.131 | -19.0659 | 0.2941 | small gap |  |
| V-WML Max [MAR] | 21.96 | Paper Table 7 Panel A, p.131 | 22.0387 | 0.0787 | small gap |  |
| V-WML Sharpe [MAR] | 0.2656 | Paper Table 7 Panel A, p.131 | 0.2697 | 0.0041 | match |  |
| WML Average [CAPM] | 1.4 | Paper Table 7 Panel B, p.131 | 1.4225 | 0.0225 | match |  |
| WML Std Dev [CAPM] | 7.02 | Paper Table 7 Panel B, p.131 | 6.9789 | -0.0411 | match |  |
| WML Skew [CAPM] | -0.4955 | Paper Table 7 Panel B, p.131 | -0.4462 | 0.0493 | match |  |
| WML Kurt [CAPM] | 5.4132 | Paper Table 7 Panel B, p.131 | 7.8183 | 2.4051 | large gap |  |
| WML Min [CAPM] | -46.77 | Paper Table 7 Panel B, p.131 | -45.2128 | 1.5572 | large gap |  |
| WML Max [CAPM] | 41.32 | Paper Table 7 Panel B, p.131 | 39.6598 | -1.6602 | large gap |  |
| WML Sharpe [CAPM] | 0.1994 | Paper Table 7 Panel B, p.131 | 0.2038 | 0.0044 | match |  |
| WML* Average [CAPM] | 1.22 | Paper Table 7 Panel B, p.131 | 1.2571 | 0.0371 | match |  |
| WML* Std Dev [CAPM] | 4.91 | Paper Table 7 Panel B, p.131 | 4.9888 | 0.0788 | small gap |  |
| WML* Skew [CAPM] | 0.1798 | Paper Table 7 Panel B, p.131 | 0.0634 | -0.1164 | small gap |  |
| WML* Kurt [CAPM] | 3.6307 | Paper Table 7 Panel B, p.131 | 7.1222 | 3.4915 | large gap |  |
| WML* Min [CAPM] | -20.35 | Paper Table 7 Panel B, p.131 | -30.2192 | -9.8692 | large gap |  |
| WML* Max [CAPM] | 34.66 | Paper Table 7 Panel B, p.131 | 32.1603 | -2.4997 | large gap |  |
| WML* Sharpe [CAPM] | 0.2485 | Paper Table 7 Panel B, p.131 | 0.252 | 0.0035 | match |  |
| V-WML Average [CAPM] | 1.28 | Paper Table 7 Panel B, p.131 | 1.3252 | 0.0452 | match |  |
| V-WML Std Dev [CAPM] | 4.62 | Paper Table 7 Panel B, p.131 | 4.6864 | 0.0664 | small gap |  |
| V-WML Skew [CAPM] | 0.0376 | Paper Table 7 Panel B, p.131 | 0.034 | -0.0036 | match |  |
| V-WML Kurt [CAPM] | 1.016 | Paper Table 7 Panel B, p.131 | 4.0088 | 2.9928 | large gap |  |
| V-WML Min [CAPM] | -16.28 | Paper Table 7 Panel B, p.131 | -16.1766 | 0.1034 | small gap |  |
| V-WML Max [CAPM] | 21.33 | Paper Table 7 Panel B, p.131 | 21.379 | 0.049 | match |  |
| V-WML Sharpe [CAPM] | 0.2773 | Paper Table 7 Panel B, p.131 | 0.2828 | 0.0055 | small gap |  |
| WML Average [FF] | 1.43 | Paper Table 7 Panel C, p.131 | 1.463 | 0.033 | match |  |
| WML Std Dev [FF] | 6.82 | Paper Table 7 Panel C, p.131 | 6.8105 | -0.0095 | match |  |
| WML Skew [FF] | -0.506 | Paper Table 7 Panel C, p.131 | -0.4769 | 0.0291 | match |  |
| WML Kurt [FF] | 7.1245 | Paper Table 7 Panel C, p.131 | 9.0937 | 1.9692 | large gap |  |
| WML Min [FF] | -49.84 | Paper Table 7 Panel C, p.131 | -46.4321 | 3.4079 | large gap |  |
| WML Max [FF] | 39.67 | Paper Table 7 Panel C, p.131 | 37.6243 | -2.0457 | large gap |  |
| WML Sharpe [FF] | 0.2097 | Paper Table 7 Panel C, p.131 | 0.2148 | 0.0051 | small gap |  |
| WML* Average [FF] | 1.26 | Paper Table 7 Panel C, p.131 | 1.3101 | 0.0501 | small gap |  |
| WML* Std Dev [FF] | 4.68 | Paper Table 7 Panel C, p.131 | 4.6304 | -0.0496 | match |  |
| WML* Skew [FF] | 0.3307 | Paper Table 7 Panel C, p.131 | 0.2128 | -0.1179 | small gap |  |
| WML* Kurt [FF] | 3.3231 | Paper Table 7 Panel C, p.131 | 5.6012 | 2.2781 | large gap |  |
| WML* Min [FF] | -22.88 | Paper Table 7 Panel C, p.131 | -21.8108 | 1.0692 | large gap |  |
| WML* Max [FF] | 26.26 | Paper Table 7 Panel C, p.131 | 24.211 | -2.049 | large gap |  |
| WML* Sharpe [FF] | 0.2692 | Paper Table 7 Panel C, p.131 | 0.2829 | 0.0137 | small gap |  |
| V-WML Average [FF] | 1.33 | Paper Table 7 Panel C, p.131 | 1.3774 | 0.0474 | match |  |
| V-WML Std Dev [FF] | 4.65 | Paper Table 7 Panel C, p.131 | 4.7258 | 0.0758 | small gap |  |
| V-WML Skew [FF] | -0.0822 | Paper Table 7 Panel C, p.131 | -0.0782 | 0.004 | match |  |
| V-WML Kurt [FF] | 2.3828 | Paper Table 7 Panel C, p.131 | 5.3283 | 2.9455 | large gap |  |
| V-WML Min [FF] | -27.96 | Paper Table 7 Panel C, p.131 | -28.6907 | -0.7307 | large gap |  |
| V-WML Max [FF] | 22.69 | Paper Table 7 Panel C, p.131 | 22.786 | 0.096 | small gap |  |
| V-WML Sharpe [FF] | 0.2858 | Paper Table 7 Panel C, p.131 | 0.2915 | 0.0057 | small gap |  |

## OOS Apr2022-Dec2024 (33 mo.)

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| WML Average [MAR] |  | paper sample ends Mar 2022 | 2.0558 |  | not comparable |  |
| WML Std Dev [MAR] |  | paper sample ends Mar 2022 | 8.8958 |  | not comparable |  |
| WML Sharpe [MAR] |  | paper sample ends Mar 2022 | 0.2311 |  | not comparable |  |
| WML* Average [MAR] |  | paper sample ends Mar 2022 | 1.6802 |  | not comparable |  |
| WML* Std Dev [MAR] |  | paper sample ends Mar 2022 | 5.2362 |  | not comparable |  |
| WML* Sharpe [MAR] |  | paper sample ends Mar 2022 | 0.3209 |  | not comparable |  |
| V-WML Average [MAR] |  | paper sample ends Mar 2022 | 0.7473 |  | not comparable |  |
| V-WML Std Dev [MAR] |  | paper sample ends Mar 2022 | 3.1075 |  | not comparable |  |
| V-WML Sharpe [MAR] |  | paper sample ends Mar 2022 | 0.2405 |  | not comparable |  |
| WML Average [CAPM] |  | paper sample ends Mar 2022 | 2.184 |  | not comparable |  |
| WML Std Dev [CAPM] |  | paper sample ends Mar 2022 | 8.7947 |  | not comparable |  |
| WML Sharpe [CAPM] |  | paper sample ends Mar 2022 | 0.2483 |  | not comparable |  |
| WML* Average [CAPM] |  | paper sample ends Mar 2022 | 1.48 |  | not comparable |  |
| WML* Std Dev [CAPM] |  | paper sample ends Mar 2022 | 5.0457 |  | not comparable |  |
| WML* Sharpe [CAPM] |  | paper sample ends Mar 2022 | 0.2933 |  | not comparable |  |
| V-WML Average [CAPM] |  | paper sample ends Mar 2022 | 0.7404 |  | not comparable |  |
| V-WML Std Dev [CAPM] |  | paper sample ends Mar 2022 | 3.0961 |  | not comparable |  |
| V-WML Sharpe [CAPM] |  | paper sample ends Mar 2022 | 0.2391 |  | not comparable |  |
| WML Average [FF] |  | paper sample ends Mar 2022 | 1.9568 |  | not comparable |  |
| WML Std Dev [FF] |  | paper sample ends Mar 2022 | 8.5986 |  | not comparable |  |
| WML Sharpe [FF] |  | paper sample ends Mar 2022 | 0.2276 |  | not comparable |  |
| WML* Average [FF] |  | paper sample ends Mar 2022 | 1.7037 |  | not comparable |  |
| WML* Std Dev [FF] |  | paper sample ends Mar 2022 | 5.5667 |  | not comparable |  |
| WML* Sharpe [FF] |  | paper sample ends Mar 2022 | 0.3061 |  | not comparable |  |
| V-WML Average [FF] |  | paper sample ends Mar 2022 | 0.6725 |  | not comparable |  |
| V-WML Std Dev [FF] |  | paper sample ends Mar 2022 | 2.9869 |  | not comparable |  |
| V-WML Sharpe [FF] |  | paper sample ends Mar 2022 | 0.2251 |  | not comparable |  |

## Table 8

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| Long (Winner) Market cap ($B) | 0.2397 | Paper Table 8, p.134 | 0.2386 | -0.0011 | match |  |
| Long (Winner) Stock share turnover | 0.1243 | Paper Table 8, p.134 | 0.088 | -0.0363 | match |  |
| Long (Winner) Amihud illiquidity | 1.343 | Paper Table 8, p.134 | 0.4996 | -0.8434 | large gap |  |
| Long (Winner) Bid-ask spread (%) | 0.9077 | Paper Table 8, p.134 | 0.7861 | -0.1216 | small gap |  |
| Long (Winner) Portfolio monthly turnover | 0.3609 | Paper Table 8, p.134 | 0.3612 | 0.0003 | match |  |
| Short (Loser) Market cap ($B) | 0.1336 | Paper Table 8, p.134 | 0.132 | -0.0016 | match |  |
| Short (Loser) Stock share turnover | 0.1116 | Paper Table 8, p.134 | 0.0695 | -0.0421 | match |  |
| Short (Loser) Amihud illiquidity | 1.5926 | Paper Table 8, p.134 | 1.6187 | 0.0261 | match |  |
| Short (Loser) Bid-ask spread (%) | 0.9939 | Paper Table 8, p.134 | 1.1364 | 0.1425 | small gap |  |
| Short (Loser) Portfolio monthly turnover | 0.4158 | Paper Table 8, p.134 | 0.4111 | -0.0047 | match |  |
| Long (Winner*) Market cap ($B) | 0.2284 | Paper Table 8, p.134 | 0.2026 | -0.0258 | match |  |
| Long (Winner*) Stock share turnover | 0.1478 | Paper Table 8, p.134 | 0.0889 | -0.0589 | small gap |  |
| Long (Winner*) Amihud illiquidity | 2.4188 | Paper Table 8, p.134 | 0.8838 | -1.535 | large gap |  |
| Long (Winner*) Bid-ask spread (%) | 1.0653 | Paper Table 8, p.134 | 0.8455 | -0.2198 | small gap |  |
| Long (Winner*) Portfolio monthly turnover | 0.5301 | Paper Table 8, p.134 | 0.5197 | -0.0104 | match |  |
| Short (Loser*) Market cap ($B) | 0.2583 | Paper Table 8, p.134 | 0.1944 | -0.0639 | small gap |  |
| Short (Loser*) Stock share turnover | 0.0872 | Paper Table 8, p.134 | 0.0486 | -0.0386 | match |  |
| Short (Loser*) Amihud illiquidity | 2.0282 | Paper Table 8, p.134 | 1.4869 | -0.5413 | large gap |  |
| Short (Loser*) Bid-ask spread (%) | 0.8511 | Paper Table 8, p.134 | 0.9077 | 0.0566 | small gap |  |
| Short (Loser*) Portfolio monthly turnover | 0.7283 | Paper Table 8, p.134 | 0.7019 | -0.0264 | match |  |

## Table A1

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| Jul 1932 WML excess | -74.06 | Paper Table A1, p.136 | -73.82 | 0.24 | small gap |  |
| Jul 1932 WML* excess | -9.61 | Paper Table A1, p.136 | -26.71 | -17.1 | large gap |  |
| Jul 1932 WML CAPM | -46.77 | Paper Table A1, p.136 | -45.21 | 1.56 | large gap |  |
| Jul 1932 WML* CAPM | -10.57 | Paper Table A1, p.136 | -30.22 | -19.65 | large gap |  |
| Jul 1932 WML FF | -9.16 | Paper Table A1, p.136 | -13.44 | -4.28 | large gap |  |
| Jul 1932 WML* FF | 2.26 | Paper Table A1, p.136 | -14.82 | -17.08 | large gap |  |
| Aug 1932 WML excess | -65.9 | Paper Table A1, p.136 | -66.88 | -0.98 | large gap |  |
| Aug 1932 WML* excess | -22.92 | Paper Table A1, p.136 | -22.08 | 0.84 | large gap |  |
| Aug 1932 WML CAPM | -22.04 | Paper Table A1, p.136 | -21.86 | 0.18 | small gap |  |
| Aug 1932 WML* CAPM | -20.35 | Paper Table A1, p.136 | -16.75 | 3.6 | large gap |  |
| Aug 1932 WML FF | 14.86 | Paper Table A1, p.136 | 11.19 | -3.67 | large gap |  |
| Aug 1932 WML* FF | -12.67 | Paper Table A1, p.136 | -3.6 | 9.07 | large gap |  |
| Jan 2001 WML excess | -38.55 | Paper Table A1, p.136 | -35.62 | 2.93 | large gap |  |
| Jan 2001 WML* excess | -11.89 | Paper Table A1, p.136 | -10.52 | 1.37 | large gap |  |
| Jan 2001 WML CAPM | -40.89 | Paper Table A1, p.136 | -37.9 | 2.99 | large gap |  |
| Jan 2001 WML* CAPM | -15.63 | Paper Table A1, p.136 | -14.41 | 1.22 | large gap |  |
| Jan 2001 WML FF | -49.84 | Paper Table A1, p.136 | -46.43 | 3.41 | large gap |  |
| Jan 2001 WML* FF | -22.88 | Paper Table A1, p.136 | -21.81 | 1.07 | large gap |  |
| Apr 2009 WML excess | -35.42 | Paper Table A1, p.136 | -35.14 | 0.28 | small gap |  |
| Apr 2009 WML* excess | -9.02 | Paper Table A1, p.136 | -9.06 | -0.04 | match |  |
| Apr 2009 WML CAPM | -29.12 | Paper Table A1, p.136 | -28.69 | 0.43 | small gap |  |
| Apr 2009 WML* CAPM | -10.77 | Paper Table A1, p.136 | -10.47 | 0.3 | small gap |  |
| Apr 2009 WML FF | -24.87 | Paper Table A1, p.136 | -23.89 | 0.98 | large gap |  |
| Apr 2009 WML* FF | -7.6 | Paper Table A1, p.136 | -8.43 | -0.83 | large gap |  |
| Jun 1938 WML excess | -34.34 | Paper Table A1, p.136 | -33.75 | 0.59 | large gap |  |
| Jun 1938 WML* excess | -4.63 | Paper Table A1, p.136 | -2.94 | 1.69 | large gap |  |
| Jun 1938 WML CAPM | -27.63 | Paper Table A1, p.136 | -27.01 | 0.62 | large gap |  |
| Jun 1938 WML* CAPM | -9.41 | Paper Table A1, p.136 | -9.14 | 0.27 | small gap |  |
| Jun 1938 WML FF | -26.94 | Paper Table A1, p.136 | -26.14 | 0.8 | large gap |  |
| Jun 1938 WML* FF | -8.43 | Paper Table A1, p.136 | -8.37 | 0.06 | small gap |  |
| Sep 1939 WML excess | -30.67 | Paper Table A1, p.136 | -30.42 | 0.25 | small gap |  |
| Sep 1939 WML* excess | 7.15 | Paper Table A1, p.136 | 5.26 | -1.89 | large gap |  |
| Sep 1939 WML CAPM | -20.93 | Paper Table A1, p.136 | -20.87 | 0.06 | small gap |  |
| Sep 1939 WML* CAPM | 4.67 | Paper Table A1, p.136 | 1.9 | -2.77 | large gap |  |
| Sep 1939 WML FF | -42.42 | Paper Table A1, p.136 | -42.78 | -0.36 | small gap |  |
| Sep 1939 WML* FF | -11.86 | Paper Table A1, p.136 | -13.48 | -1.62 | large gap |  |
| Jun 1931 WML excess | -29.93 | Paper Table A1, p.136 | -29.68 | 0.25 | small gap |  |
| Jun 1931 WML* excess | 1.27 | Paper Table A1, p.136 | -3.03 | -4.3 | large gap |  |
| Jun 1931 WML CAPM | -24.85 | Paper Table A1, p.136 | -24.24 | 0.61 | large gap |  |
| Jun 1931 WML* CAPM | -2.19 | Paper Table A1, p.136 | -6.93 | -4.74 | large gap |  |
| Jun 1931 WML FF | -17.84 | Paper Table A1, p.136 | -18.25 | -0.41 | small gap |  |
| Jun 1931 WML* FF | 4.59 | Paper Table A1, p.136 | 1.14 | -3.45 | large gap |  |
| Apr 1933 WML excess | -27.01 | Paper Table A1, p.136 | -27.01 | 0.0 | match |  |
| Apr 1933 WML* excess | -0.24 | Paper Table A1, p.136 | 2.26 | 2.5 | large gap |  |
| Apr 1933 WML CAPM | 27.64 | Paper Table A1, p.136 | 27.96 | 0.32 | small gap |  |
| Apr 1933 WML* CAPM | 10.36 | Paper Table A1, p.136 | 14.79 | 4.43 | large gap |  |
| Apr 1933 WML FF | 24.36 | Paper Table A1, p.136 | 24.79 | 0.43 | small gap |  |
| Apr 1933 WML* FF | 10.44 | Paper Table A1, p.136 | 12.96 | 2.52 | large gap |  |
| Feb 2021 WML excess | -21.81 | Paper Table A1, p.136 | -21.84 | -0.03 | match |  |
| Feb 2021 WML* excess | -11.29 | Paper Table A1, p.136 | -12.92 | -1.63 | large gap |  |
| Feb 2021 WML CAPM | -20.13 | Paper Table A1, p.136 | -20.19 | -0.06 | small gap |  |
| Feb 2021 WML* CAPM | -11.74 | Paper Table A1, p.136 | -13.29 | -1.55 | large gap |  |
| Feb 2021 WML FF | -11.74 | Paper Table A1, p.136 | -11.64 | 0.1 | small gap |  |
| Feb 2021 WML* FF | -8.64 | Paper Table A1, p.136 | -9.66 | -1.02 | large gap |  |
| Mar 2000 WML excess | -20.37 | Paper Table A1, p.136 | -19.62 | 0.75 | large gap |  |
| Mar 2000 WML* excess | -6.42 | Paper Table A1, p.136 | -6.83 | -0.41 | small gap |  |
| Mar 2000 WML CAPM | -21.96 | Paper Table A1, p.136 | -21.23 | 0.73 | large gap |  |
| Mar 2000 WML* CAPM | -9.66 | Paper Table A1, p.136 | -9.93 | -0.27 | small gap |  |
| Mar 2000 WML FF | 0.44 | Paper Table A1, p.136 | 2.31 | 1.87 | large gap |  |
| Mar 2000 WML* FF | 12.05 | Paper Table A1, p.136 | 13.58 | 1.53 | large gap |  |
| Average WML excess | -37.8 | Paper Table A1, p.136 | -37.38 | 0.42 | small gap |  |
| Average WML* excess | -6.76 | Paper Table A1, p.136 | -8.66 | -1.9 | large gap |  |
| Average WML CAPM | -22.67 | Paper Table A1, p.136 | -21.92 | 0.75 | large gap |  |
| Average WML* CAPM | -7.53 | Paper Table A1, p.136 | -9.45 | -1.92 | large gap |  |
| Average WML FF | -14.32 | Paper Table A1, p.136 | -14.43 | -0.11 | small gap |  |
| Average WML* FF | -4.27 | Paper Table A1, p.136 | -5.25 | -0.98 | large gap |  |
| V-WML column (all 10 months available) |  | paper A1 has no V-WML | -10.47 |  | not comparable | average V-WML in the 10 crash months |
| 10 crash months identical to paper's list | 10.0 | Paper Table A1 | 10 of 10 (same ranking) |  | match |  |

## Table A4

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| 1930-1949 WML Average | 0.49 | Paper Table A4 panel A, p.137 | 0.375 | -0.115 | small gap |  |
| 1930-1949 WML Std Dev | 10.17 | Paper Table A4 panel A, p.137 | 10.202 | 0.032 | match |  |
| 1930-1949 WML Sharpe | 0.0481 | Paper Table A4 panel A, p.137 | 0.037 | -0.0111 | small gap |  |
| 1930-1949 WML* Average | 1.74 | Paper Table A4 panel A, p.137 | 1.671 | -0.069 | small gap |  |
| 1930-1949 WML* Std Dev | 5.24 | Paper Table A4 panel A, p.137 | 5.318 | 0.078 | small gap |  |
| 1930-1949 WML* Sharpe | 0.3318 | Paper Table A4 panel A, p.137 | 0.314 | -0.0178 | small gap |  |
| 1950-1969 WML Average | 1.5 | Paper Table A4 panel A, p.137 | 1.553 | 0.053 | small gap |  |
| 1950-1969 WML Std Dev | 4.32 | Paper Table A4 panel A, p.137 | 4.326 | 0.006 | match |  |
| 1950-1969 WML Sharpe | 0.3467 | Paper Table A4 panel A, p.137 | 0.359 | 0.0123 | small gap |  |
| 1950-1969 WML* Average | 1.57 | Paper Table A4 panel A, p.137 | 1.537 | -0.033 | match |  |
| 1950-1969 WML* Std Dev | 3.86 | Paper Table A4 panel A, p.137 | 3.782 | -0.078 | small gap |  |
| 1950-1969 WML* Sharpe | 0.4073 | Paper Table A4 panel A, p.137 | 0.407 | -0.0003 | match |  |
| 1970-1989 WML Average | 1.61 | Paper Table A4 panel A, p.137 | 1.645 | 0.035 | match |  |
| 1970-1989 WML Std Dev | 5.95 | Paper Table A4 panel A, p.137 | 5.908 | -0.042 | match |  |
| 1970-1989 WML Sharpe | 0.2705 | Paper Table A4 panel A, p.137 | 0.278 | 0.0075 | small gap |  |
| 1970-1989 WML* Average | 1.46 | Paper Table A4 panel A, p.137 | 1.502 | 0.042 | match |  |
| 1970-1989 WML* Std Dev | 4.37 | Paper Table A4 panel A, p.137 | 4.405 | 0.035 | match |  |
| 1970-1989 WML* Sharpe | 0.3331 | Paper Table A4 panel A, p.137 | 0.341 | 0.0079 | small gap |  |
| 1990-2009 WML Average | 1.44 | Paper Table A4 panel A, p.137 | 1.524 | 0.084 | small gap |  |
| 1990-2009 WML Std Dev | 8.82 | Paper Table A4 panel A, p.137 | 8.717 | -0.103 | small gap |  |
| 1990-2009 WML Sharpe | 0.1635 | Paper Table A4 panel A, p.137 | 0.175 | 0.0115 | small gap |  |
| 1990-2009 WML* Average | 1.25 | Paper Table A4 panel A, p.137 | 1.356 | 0.106 | small gap |  |
| 1990-2009 WML* Std Dev | 6.26 | Paper Table A4 panel A, p.137 | 6.35 | 0.09 | small gap |  |
| 1990-2009 WML* Sharpe | 0.1999 | Paper Table A4 panel A, p.137 | 0.213 | 0.0131 | small gap |  |
| 2010-2022 WML Average | 0.76 | Paper Table A4 panel A, p.137 | 0.858 | 0.098 | small gap |  |
| 2010-2022 WML Std Dev | 6.34 | Paper Table A4 panel A, p.137 | 6.328 | -0.012 | match |  |
| 2010-2022 WML Sharpe | 0.1205 | Paper Table A4 panel A, p.137 | 0.136 | 0.0155 | small gap |  |
| 2010-2022 WML* Average | 0.53 | Paper Table A4 panel A, p.137 | 0.5 | -0.03 | match |  |
| 2010-2022 WML* Std Dev | 4.56 | Paper Table A4 panel A, p.137 | 4.558 | -0.002 | match |  |
| 2010-2022 WML* Sharpe | 0.1157 | Paper Table A4 panel A, p.137 | 0.11 | -0.0057 | small gap |  |

## Table A4 (V-WML, no paper row)

| statistic | paper | paper ref | replication | difference | status | note |
|---|---|---|---|---|---|---|
| 1930-1949 V-WML Sharpe |  | paper A4 has no V-WML | 0.109 |  | not comparable |  |
| 1950-1969 V-WML Sharpe |  | paper A4 has no V-WML | 0.386 |  | not comparable |  |
| 1970-1989 V-WML Sharpe |  | paper A4 has no V-WML | 0.352 |  | not comparable |  |
| 1990-2009 V-WML Sharpe |  | paper A4 has no V-WML | 0.264 |  | not comparable |  |
| 2010-2022 V-WML Sharpe |  | paper A4 has no V-WML | 0.195 |  | not comparable |  |
