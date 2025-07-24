USE [msdb]
GO

/****** Object:  Job [B_CSH_BAK_TXN_EXEC]    Script Date: 7/24/2025 8:35:02 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Data Collector]    Script Date: 7/24/2025 8:35:02 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Data Collector' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Data Collector'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'B_CSH_BAK_TXN_EXEC', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'EDC/POS Cash Back Transaction', 
		@category_name=N'Data Collector', 
		@owner_login_name=N'KASIKORNBANK\Administrator', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [B_ADD_TXN_INFO_EXEC]    Script Date: 7/24/2025 8:35:02 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'B_ADD_TXN_INFO_EXEC', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- B_ADD_TXN_INFO_EXEC
USE [KCARD];
GO

-- Optional: Preview data before insertion
SELECT * FROM D_CASHBACK;

BEGIN TRAN;

INSERT INTO D_CASHBACK (
    [TXREFID], [EXTREF], [CHAR01], [CUSCODE], [CARDNO], [RRN], [CARDBIN], [CSHAMT], [FEECODE],
    [FEEAMT], [STATUS], [TXDT], [TMNINFO], [XREF], [CHAR02], [ACNO]
)
SELECT TOP 1 
    LOWER(NEWID())           AS TXREFID,
    XREF                     AS EXTREF,
    TRANCODE                 AS CHAR01,
    CUSCODE,
    CARDNO,
    RRN,
    CARDBIN,
    (
        SELECT TOP 1 CAST(CODEID AS DECIMAL(19,2))
        FROM (
            SELECT CODEID FROM D_CODETYPE WHERE CODETYPE = ''CSHAMT'' AND CODESUBTYPE = ''CSHBAK''
            UNION ALL
            SELECT CODEID FROM D_CODETYPE WHERE CODETYPE = ''CSHAMT'' AND CODEID = ''100'' AND CODESUBTYPE = ''CSHBAK''
            UNION ALL
            SELECT CODEID FROM D_CODETYPE WHERE CODETYPE = ''CSHAMT'' AND CODEID = ''200'' AND CODESUBTYPE = ''CSHBAK''
            UNION ALL
            SELECT CODEID FROM D_CODETYPE WHERE CODETYPE = ''CSHAMT'' AND CODEID = ''500'' AND CODESUBTYPE = ''CSHBAK''
            UNION ALL
            SELECT CODEID FROM D_CODETYPE WHERE CODETYPE = ''CSHAMT'' AND CODEID = ''900'' AND CODESUBTYPE = ''CSHBAK''
        ) AS WeightedPool
        ORDER BY NEWID()
    )                        AS CSHAMT,
    ''{}''                     AS FEECODE,
    0.00                     AS FEEAMT,
    STS                      AS STATUS,
    TXDT,
    REFVAL02                 AS TMNINFO,
    TNO                      AS XREF,
    REFVAL01                 AS CHAR02,
    CUSACCR                  AS ACNO
FROM D_CDSTM
WHERE 
    TXCODE IN (''0007'', ''0011'')
    AND STS = ''C''
    AND REFVAL04 IS NULL AND CARDTYPE = ''D''
ORDER BY NEWID();

COMMIT TRAN;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_UPD_TXN_BDY_EXEC]    Script Date: 7/24/2025 8:35:02 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_UPD_TXN_BDY_EXEC', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_UPD_TXN_BDY_EXEC
USE [KCARD];
GO

BEGIN TRAN;

UPDATE D_CASHBACK
SET 
    TXCODE = CASE 
                WHEN CHAR01 = ''DPT_POS_PAY'' THEN ''0008''
                WHEN CHAR01 = ''DPT_EDC_PAY'' THEN ''0012''
             END,
    DESCS = CASE 
                WHEN CHAR01 = ''DPT_POS_PAY'' THEN ''POS with Cashback''
                WHEN CHAR01 = ''DPT_EDC_PAY'' THEN ''EDC Payment with Cashback''
            END,
    TRANCODE = CASE 
                  WHEN CHAR01 = ''DPT_POS_PAY'' THEN ''DPT_POS_CSH_WTD''
                  WHEN CHAR01 = ''DPT_EDC_PAY'' THEN ''DPT_EDC_CSH_WTD''
               END,
    COMCODE = CASE 
                 WHEN CHAR01 = ''DPT_POS_PAY'' THEN ''POS_CSH_WTD''
                 WHEN CHAR01 = ''DPT_EDC_PAY'' THEN ''EDC_CSH_WTD''
              END,
    PCODE = CASE 
                WHEN CHAR01 = ''DPT_POS_PAY'' THEN ''POS_CSH_WTD''
                WHEN CHAR01 = ''DPT_EDC_PAY'' THEN ''EDC_CSH_WTD''
            END,
    CHAR03 = CASE 
                WHEN CHAR01 = ''DPT_POS_PAY'' THEN ''POS with Cashback''
                WHEN CHAR01 = ''DPT_EDC_PAY'' THEN ''EDC Payment with Cashback''
             END
WHERE TXCODE IS NULL;

COMMIT TRAN;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_UPD_TXN_LOG_EXEC]    Script Date: 7/24/2025 8:35:02 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_UPD_TXN_LOG_EXEC', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_UPD_TXN_LOG_EXEC
USE [KCARD];
GO

BEGIN TRAN;

UPDATE D_CDSTM
SET
    REFVAL04 = ''{"tx_code":"CSH_BACK","status":"SUCCESS","sts":"COMPLETE"}'',
    CHAR27   = ''{"tran_type":"Cash Back Transaction"}'',
    CHAR29   = ''{"csh_bak_sts":"Transaction Success"}''
WHERE 
    TNO IN (
        SELECT XREF 
        FROM D_CASHBACK 
        WHERE CHAR05 IS NULL
    )
    AND REFVAL04 IS NULL AND CARDTYPE = ''D'';

COMMIT TRAN;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_WFW_STM_EXEC]    Script Date: 7/24/2025 8:35:02 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_WFW_STM_EXEC', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_ADD_WFW_STM_EXEC
USE [KCARD];
GO

-- Step 1: Insert each row into D_WFSTM as individual JSON object
DECLARE @ID INT;

DECLARE row_cursor CURSOR FOR
    SELECT RECID
    FROM D_CASHBACK 
    WHERE CHAR04 IS NULL AND CHAR05 IS NULL;

OPEN row_cursor;
FETCH NEXT FROM row_cursor INTO @ID;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO D_WFSTM (REQUESTMSG)
    SELECT 
        (SELECT * 
         FROM D_CASHBACK
         WHERE RECID = @ID AND CHAR04 IS NULL AND CHAR05 IS NULL
         FOR JSON PATH, WITHOUT_ARRAY_WRAPPER) AS JsonData;

    FETCH NEXT FROM row_cursor INTO @ID;
END

CLOSE row_cursor;
DEALLOCATE row_cursor;

-- Step 2: Update extracted fields and workflow metadata in D_WFSTM
BEGIN TRAN;

UPDATE D_WFSTM
SET
    TXDT        = JSON_VALUE(REQUESTMSG, ''$.TXDT''),
    TXREFID     = JSON_VALUE(REQUESTMSG, ''$.TXREFID''),
    TXCODE      = JSON_VALUE(REQUESTMSG, ''$.TRANCODE''),
    WFBODY      = REQUESTMSG,
    RESPONSEMSG = REQUESTMSG,
    WFCODE      = ''WF_PAY|WF_SUC'',
    WFSTS       = ''C'',
    WFEXDT      = JSON_VALUE(REQUESTMSG, ''$.TXDT'')
WHERE TXCODE IS NULL;

COMMIT TRAN;

-- Step 3: Log import into D_CASHBACK
BEGIN TRAN;

UPDATE D_CASHBACK
SET CHAR04 = ''{"object":"D_WFSTSM","action_type":"import","status":"C"}'',
CHAR05  = ''Transaction successfully!''
WHERE CHAR04 IS NULL AND CHAR05 IS NULL
COMMIT TRAN;
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'B_CSH_BAK_TXN_EXEC_AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=8, 
		@freq_subday_interval=3, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20250723, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=55959, 
		@schedule_uid=N'84fa9514-5bf4-402b-91d5-cd7e04617240'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'B_CSH_BAK_TXN_EXEC_PM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=30, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20250723, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959, 
		@schedule_uid=N'1349c828-70eb-4e73-a16a-a24ca760d023'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


