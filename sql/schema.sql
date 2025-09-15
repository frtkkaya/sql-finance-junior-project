PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS companies;
CREATE TABLE companies (
  ticker TEXT PRIMARY KEY,
  name   TEXT NOT NULL,
  sector TEXT NOT NULL,
  country TEXT NOT NULL,
  listed_date DATE NOT NULL
);

DROP TABLE IF EXISTS prices;
CREATE TABLE prices (
  ticker TEXT NOT NULL,
  trade_date DATE NOT NULL,
  close REAL NOT NULL,
  PRIMARY KEY (ticker, trade_date),
  FOREIGN KEY (ticker) REFERENCES companies(ticker)
);

DROP TABLE IF EXISTS trades;
CREATE TABLE trades (
  trade_id INTEGER PRIMARY KEY,
  trade_ts TEXT NOT NULL,
  ticker TEXT NOT NULL,
  side TEXT CHECK (side IN ('BUY','SELL')) NOT NULL,
  qty INTEGER NOT NULL,
  px_ccy TEXT NOT NULL,
  px REAL NOT NULL,
  FOREIGN KEY (ticker) REFERENCES companies(ticker)
);

DROP TABLE IF EXISTS fx_rates;
CREATE TABLE fx_rates (
  ccy TEXT NOT NULL,
  rate_date DATE NOT NULL,
  try_per_unit REAL NOT NULL,
  PRIMARY KEY (ccy, rate_date)
);
