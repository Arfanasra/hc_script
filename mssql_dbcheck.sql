use ACE;
GO
SELECT 
    DB_NAME(mf.database_id) AS DatabaseName,
    mf.name AS FileName,
    mf.physical_name AS FilePath,
    CAST(mf.size * 8 / 1024.0 / 1024.0 AS DECIMAL(10,2)) AS AllocatedSpaceGB,
    CAST(FILEPROPERTY(mf.name, 'SpaceUsed') * 8 / 1024.0 / 1024.0 AS DECIMAL(10,2)) AS UsedSpaceGB,
    CAST((mf.size - FILEPROPERTY(mf.name, 'SpaceUsed')) * 8 / 1024.0 / 1024.0 AS DECIMAL(10,2)) AS FreeSpaceGB
FROM sys.master_files mf
WHERE type_desc = 'ROWS'
  AND DB_NAME(mf.database_id) NOT IN ('TIS','master', 'model', 'msdb', 'tempdb');
 
use TIS;
GO
SELECT 
    DB_NAME(mf.database_id) AS DatabaseName,
    mf.name AS FileName,
    mf.physical_name AS FilePath,
    CAST(mf.size * 8 / 1024.0 / 1024.0 AS DECIMAL(10,2)) AS AllocatedSpaceGB,
    CAST(FILEPROPERTY(mf.name, 'SpaceUsed') * 8 / 1024.0 / 1024.0 AS DECIMAL(10,2)) AS UsedSpaceGB,
    CAST((mf.size - FILEPROPERTY(mf.name, 'SpaceUsed')) * 8 / 1024.0 / 1024.0 AS DECIMAL(10,2)) AS FreeSpaceGB
FROM sys.master_files mf
WHERE type_desc = 'ROWS'
  AND DB_NAME(mf.database_id) NOT IN ('ACE','master', 'model', 'msdb', 'tempdb');
 
SELECT 
    database_name AS DatabaseName,
    MAX(backup_finish_date) AS LastBackupDate,
    CASE 
        WHEN MAX(backup_finish_date) < DATEADD(DAY, -1, GETDATE()) THEN 'Backup Overdue'
        ELSE 'Backup OK'
    END AS BackupStatus
FROM msdb.dbo.backupset
WHERE type = 'D' -- Full Backup
  AND database_name NOT IN ('master', 'model', 'msdb', 'tempdb')
GROUP BY database_name;