USE [msdb]
GO

/****** Object:  Job [B_SYC_DBT_CAD_EXEC]    Script Date: 7/24/2025 8:37:47 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Data Collector]    Script Date: 7/24/2025 8:37:47 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Data Collector' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Data Collector'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'B_SYC_DBT_CAD_EXEC', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Sync KCard Debit Card Infor Job', 
		@category_name=N'Data Collector', 
		@owner_login_name=N'KASIKORNBANK\Administrator', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_CARD_INFO_EXEC]    Script Date: 7/24/2025 8:37:47 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_CARD_INFO_EXEC', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [KCARD];
GO
DECLARE @MaxLoop INT = ROUND(RAND() * 10, 0)
DECLARE @i INT = 1;

WHILE @i <= @MaxLoop
BEGIN
    DECLARE @RandomString NVARCHAR(MAX) = N'''';
    DECLARE @RandomChar NVARCHAR(1);
    DECLARE @Counter INT = 0;
    DECLARE @Length INT = 255;
    DECLARE @Chars NVARCHAR(62) = ''ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789'';

    -- Generate random 255-character token
    WHILE @Counter < @Length
    BEGIN
        SET @RandomChar = SUBSTRING(@Chars, ABS(CHECKSUM(NEWID())) % LEN(@Chars) + 1, 1);
        SET @RandomString = @RandomString + @RandomChar;
        SET @Counter = @Counter + 1;
    END

    BEGIN TRAN;
	INSERT INTO D_CARDLST
	(BANKID,
	BRANCHCODE,
	CUSACC,
	CARDTYPE,
	CARDCAT,
	CARDSTS,
	SYNCTOKEN,
	CARDBIN,
	ISDEBITCD,
	ISCREDITCD,
	ISVERIFY,
	OPENDT,
	SYNCDT,
	CARDREFNO,
	CARDPIN,
	MAKER,
	APPROVER,
	CREATEDT)
	VALUES
	(
	''KBANK'',
	(SELECT TOP 1 BRANCHCODE FROM D_BRANCHCODE WHERE BRANCHCODE <> ''0001'' ORDER BY NEWID()),
	CAST((ABS(CHECKSUM(NEWID())) % 9000000000 + 1000000000) AS VARCHAR(10)),
	''D'',
	(SELECT TOP 1 CODEID FROM D_CODETYPE WHERE CODETYPE = ''DEBITCARD'' AND CODESUBTYPE = ''DCTYPE'' ORDER BY NEWID()),
	''P'',
	@RandomString,
	RIGHT(''00000000'' + CAST(ABS(CHECKSUM(NEWID())) % 100000000 AS NVARCHAR), 8),
	''Y'',
	''Y'',
	''P'',
	DATEADD(DAY, ABS(CHECKSUM(NEWID())) % DATEDIFF(DAY, ''2015-01-01'', GETDATE()), ''2015-01-01''),
	CAST(GETDATE() AS date),
	REPLACE(LOWER(NEWID()),''-'',''''),
	RIGHT(''000000'' + CAST(ABS(CHECKSUM(NEWID())) % 1000000 AS NVARCHAR), 6),
	''1a596afb-0de3-4bbc-b152-d0d4dbebd412'',
	''1a596afb-0de3-4bbc-b152-d0d4dbebd412'',
	GETUTCDATE()
	)
    COMMIT TRAN;

    SET @i += 1;
END;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_UPD_CARD_INFO_EXEC]    Script Date: 7/24/2025 8:37:47 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_UPD_CARD_INFO_EXEC', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_UPD_CARD_INFO_EXEC
USE [KCARD]
GO

BEGIN TRAN;
UPDATE D_CARDLST
SET 
CARDNO = CONCAT(''95'',RIGHT(''00000000'' + CAST(RECID AS NVARCHAR), 8)),
CUSCODE = CONCAT(''40'',RIGHT(''000000'' + CAST(RECID AS NVARCHAR), 6)),
RRN = FORMAT(GETDATE(), ''yyyyMMdd'') + RIGHT(''00000000'' + CAST(RECID AS NVARCHAR), 8)
WHERE CARDSTS = ''P'' AND ISVERIFY = ''P'' AND CARDTYPE = ''D''
COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ECY_CARD_PWD_EXEC]    Script Date: 7/24/2025 8:37:47 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ECY_CARD_PWD_EXEC', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_ECY_CARD_PWD_EXEC
USE [KCARD]
GO

-- exec
-- open key
OPEN SYMMETRIC KEY [kcard_symkey]
DECRYPTION BY CERTIFICATE [kcard_cert];
UPDATE [KCARD].dbo.[D_CARDLST]
SET [HASHPIN] = EncryptByKey (Key_GUID(''[kcard_symkey]''), [CARDPIN])
FROM [KCARD].dbo.[D_CARDLST]
WHERE HASHPIN IS NULL AND CARDTYPE = ''D''
GO
-- close key
CLOSE SYMMETRIC KEY [kcard_symkey];
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_SYS_LOG_EXEC]    Script Date: 7/24/2025 8:37:47 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_SYS_LOG_EXEC', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_ADD_SYS_LOG_EXEC
USE [KCARD]
GO

-- Insert each row from YourTable into YourJsonTable as a separate JSON object
DECLARE @ID INT;

DECLARE row_cursor CURSOR FOR
SELECT RECID
FROM D_CARDLST WHERE CARDSTS = ''P'' AND ISVERIFY = ''P'' AND CARDTYPE = ''D''

OPEN row_cursor;
FETCH NEXT FROM row_cursor INTO @ID;

WHILE @@FETCH_STATUS = 0
BEGIN
    -- Insert each row as a separate JSON object into YourJsonTable
    INSERT INTO SYSLOG(DESCS)
    SELECT 
        (SELECT *
         FROM D_CARDLST
         WHERE RECID = @ID AND CARDSTS = ''P'' AND ISVERIFY = ''P'' AND CARDTYPE = ''D''
         FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS JsonData;
    
    FETCH NEXT FROM row_cursor INTO @ID;
END

CLOSE row_cursor;
DEALLOCATE row_cursor;

-- update
begin tran;
update SYSLOG
set LOGREF = FORMAT(GETDATE(), ''yyyyMMdd'') + RIGHT(''0000000000'' + CAST(RECID AS NVARCHAR), 10),
ACTION_TYPE = ''Sync Debit Card/Insert'',
ACTION_USR_ID = ''1a596afb-0de3-4bbc-b152-d0d4dbebd412'',
TARGET_USER_ID = ''D_CARDLST'',
LOGSTS = ''C'',
LOGDT = GETUTCDATE()
WHERE ACTION_TYPE IS NULL;
commit tran;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_UPD_CARD_LOG_EXEC]    Script Date: 7/24/2025 8:37:47 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_UPD_CARD_LOG_EXEC', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_UPD_CARD_LOG_EXEC
USE [KCARD]
GO

BEGIN TRAN;
UPDATE D_CARDLST
SET ISVERIFY = ''Y'',
CARDSTS = ''N''
WHERE CARDSTS = ''P'' AND ISVERIFY = ''P'' AND CARDTYPE = ''D''
COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'B_SYC_DBT_CAD_EXEC', 
		@enabled=1, 
		@freq_type=8, 
		@freq_interval=62, 
		@freq_subday_type=4, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=1, 
		@active_start_date=20250721, 
		@active_end_date=99991231, 
		@active_start_time=90000, 
		@active_end_time=185959, 
		@schedule_uid=N'd9376f74-f652-4b5e-8a1c-2834f053c23e'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


