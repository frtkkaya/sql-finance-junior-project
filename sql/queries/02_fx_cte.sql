-- Convert USD trades to TRY notionals by joining daily FX

WITH d AS (
  SELECT t.trade_id, t.trade_ts, t.ticker, t.side, t.qty, t.px_ccy, t.px,
         DATE(t.trade_ts) AS dte
  FROM trades t
)
SELECT d.trade_id,
       d.ticker,
       d.side,
       d.qty,
       d.px_ccy,
       d.px,
       CASE WHEN d.px_ccy='USD' THEN d.px * f.try_per_unit ELSE d.px END AS px_try
FROM d
LEFT JOIN fx_rates f ON f.ccy='USD' AND f.rate_date=d.dte
ORDER BY d.trade_id;
