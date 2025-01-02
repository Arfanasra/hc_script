DECLARE @LogNumber INT = 0;
DECLARE @MaxLogNumber INT;
-- Find the maximum log number (i.e., how many logs are available)
EXEC xp_fileexist N'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log\ERRORLOG', @MaxLogNumber OUTPUT;

-- Loop through each error log and output the data
WHILE @LogNumber <= @MaxLogNumber
BEGIN
    PRINT 'Reading log number ' + CAST(@LogNumber AS VARCHAR);
    EXEC sp_readerrorlog @LogNumber, 1, N'error'; -- Read log
    SET @LogNumber = @LogNumber + 1;
END
