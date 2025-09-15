-- Author: F. Akkaya (Sep 2025)
-- Goal: Warm-up on grouping and latest-row selection. SQLite portable.

-- 1) Count companies by country
SELECT country, COUNT(*) AS n
FROM companies
GROUP BY country
ORDER BY n DESC;

-- 2) Latest close per ticker via CTE
WITH latest AS (
  SELECT ticker, MAX(trade_date) AS max_d
  FROM prices
  GROUP BY ticker
)
SELECT p.ticker, p.trade_date, p.close
FROM prices p
JOIN latest l ON l.ticker = p.ticker AND l.max_d = p.trade_date
ORDER BY p.ticker;
