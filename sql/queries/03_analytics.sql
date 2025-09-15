-- Sector-relative 2-day momentum z-score (illustrative on tiny data)
WITH last2 AS (
  SELECT c.sector, p.ticker, p.trade_date, p.close,
         ROW_NUMBER() OVER (PARTITION BY p.ticker ORDER BY p.trade_date DESC) rn
  FROM prices p JOIN companies c USING(ticker)
),
perf AS (
  SELECT a.sector, a.ticker,
         (a.close - b.close) / b.close AS mom2
  FROM last2 a JOIN last2 b ON a.ticker=b.ticker AND a.rn=1 AND b.rn=2
),
stats AS (
  SELECT sector, AVG(mom2) AS mu, STDDEV_POP(mom2) AS sig
  FROM perf GROUP BY sector
)
SELECT p.ticker, p.sector,
       ROUND((p.mom2 - s.mu)/NULLIF(s.sig,0), 3) AS z_score
FROM perf p JOIN stats s USING(sector)
ORDER BY z_score DESC;
