@echo off
set DB=lab.db
where sqlite3 >nul 2>nul
if %errorlevel% neq 0 (
  echo Please install sqlite3 and ensure it is on PATH.
  exit /b 1
)
if exist %DB% del %DB%
sqlite3 %DB% < sql\schema.sql
sqlite3 %DB% ".read sql\seed.sql"
echo Database created: %DB%
