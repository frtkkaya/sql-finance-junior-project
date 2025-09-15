-- Window functions: moving averages and running cash flow

-- 5-day moving average (toy horizon here)
SELECT ticker, trade_date, close,
       ROUND(AVG(close) OVER (PARTITION BY ticker ORDER BY trade_date ROWS BETWEEN 4 PRECEDING AND CURRENT ROW), 4) AS ma5
FROM prices
ORDER BY ticker, trade_date;

-- Running cash flow per ticker (BUY negative, SELL positive)
SELECT ticker,
       trade_ts,
       side,
       qty,
       px,
       CASE WHEN side='BUY' THEN -qty*px ELSE qty*px END AS cash_flow,
       SUM(CASE WHEN side='BUY' THEN -qty*px ELSE qty*px END)
         OVER (PARTITION BY ticker ORDER BY trade_ts) AS cum_cash_flow
FROM trades
ORDER BY ticker, trade_ts;
