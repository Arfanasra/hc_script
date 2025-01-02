@echo off
 
Powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& './oscheck_ps.ps1'" > oscheck_%COMPUTERNAME%.txt
 
SQLCMD -i %cd%\mssql_dbcheck.sql -o %cd%\mssql_dbcheck_%COMPUTERNAME%.txt 

SQLCMD -i %cd%\exportErrorlog.sql -o %cd%\errorlog_%COMPUTERNAME%.txt

pause