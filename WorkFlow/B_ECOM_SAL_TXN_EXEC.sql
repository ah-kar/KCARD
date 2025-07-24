USE [msdb]
GO

/****** Object:  Job [B_ECOM_SAL_TXN_EXEC]    Script Date: 7/24/2025 8:35:35 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Data Collector]    Script Date: 7/24/2025 8:35:35 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Data Collector' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Data Collector'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'B_ECOM_SAL_TXN_EXEC', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'E-Commerce Sale', 
		@category_name=N'Data Collector', 
		@owner_login_name=N'KASIKORNBANK\Administrator', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_TXN_INFO_EXEC]    Script Date: 7/24/2025 8:35:35 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_TXN_INFO_EXEC', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_ADD_TXN_INFO_EXEC
USE [KCARD]
GO

DECLARE @count INT = 0;

WHILE @count <= ROUND(RAND() * 3, 0)
BEGIN
    BEGIN TRAN;

    INSERT INTO [D_CDSTM] 
    (
        [TXREFID], [TXTIME], [MID], [USRID], [CHAR01], [TXCODE], [TRANCODE], [BCODE], [PAYCODE], [PAYREFNO],
        [BANKID], [SWIFTCODE], [MERCHANTID], [NOTIFYMAIL], [AMT], [CCYCODE], [REGION], [FEECODE],
        [FEEVAL01], [FEEVAL02], [COMCODE], [ISONUS], [ISOFFUS], [PCODE], [TRANTYPE], [ISOFFLINE], [ISONLINE],
        [RSTS], [WFSTS], [TXSTS], [WFCODE], [DESCS], [REFVAL01], [REFVAL02], [REFVAL10],
        [CHAR02], [NUM03], [NUM04], [DATE01], [DATE2], [DATE03], [REFVAL05],[REFVAL07]
    )
    VALUES
    (
        LOWER(NEWID()), -- TXREFID
        (SELECT FORMAT(GETDATE(), ''HH.mm.ss'')), -- TXTIME
        ''kcard'', -- MID
        ''8073c0a9-3cc8-40a9-b3e8-214a1876450b'', -- USRID
        RIGHT(''000000'' + CAST(ABS(CHECKSUM(NEWID())) % 1000000 AS NVARCHAR), 6), -- CHAR01
        ''0015'', -- TXCODE
        ''DPT_ECOM_PUR'', -- TRANCODE
        ''901'', -- BCODE
        ''CARD_PAY'', -- PAYCODE
        ''-'', -- PAYREFNO
        ''KBANK'', -- BANKID
        ''KASITHBK'', -- SWIFTCODE
        ''-'', -- MERCHANTID
        ''noreply-kcard@kbank.com,info-kcard@kbank.com'', -- NOTIFYMAIL
		(
        SELECT CASE 
            WHEN ROUND(RAND() * 10000, -2) = 0 THEN 100 
            ELSE ROUND(RAND() * 10000, -2) 
        END
		), -- AMT
        ''THB'', -- CCYCODE
        ''TH'', -- REGION
        ''{"fee_code01":"ECOM_FEE","fee_code02":"ECOM_CHG"}'', -- FEECODE
        5.00, -- FEEVAL01
        5.00, -- FEEVAL02
        (SELECT TOP 1 CODEID FROM D_CODETYPE WHERE CODETYPE = ''ECOM'' ORDER BY NEWID()), -- COMCODE
        ''N'', -- ISONUS
        ''N'', -- ISOFFUS
        ''ECOM_PUR'', -- PCODE
        ''Online'', -- TRANTYPE
        ''N'', -- ISOFFLINE
        ''Y'', -- ISONLINE
        ''C'', -- RSTS
        ''C'', -- WFSTS

        (SELECT TOP 1 CODEID
         FROM (
             SELECT CODEID FROM D_CODETYPE WHERE CODETYPE = ''STS'' AND CODESUBTYPE = ''TXSTATUS''
             UNION ALL
             SELECT CODEID FROM D_CODETYPE WHERE CODETYPE = ''STS'' AND CODEID = ''C'' AND CODESUBTYPE = ''TXSTATUS''
             UNION ALL
             SELECT CODEID FROM D_CODETYPE WHERE CODETYPE = ''STS'' AND CODEID = ''C'' AND CODESUBTYPE = ''TXSTATUS''
         ) AS WeightedPool
         ORDER BY NEWID()), -- TXSTS

        ''WF_CAD_PAY'', -- WFCODE
        ''E-commerce Purchase'', -- DESCS

        (SELECT TOP 1 CUSCODE, BRANCHCODE, CUSACC, CARDNO, CARDTYPE, CARDCAT, RRN, CARDBIN
         FROM D_CARDLST 
         ORDER BY NEWID() 
         FOR JSON PATH), -- REFVAL01
        ''{
            "log_type":"device_id",
            "app_code":"mobile",
            "web_code":"web",
            "tx_channel":"MB/IB"
        }'', -- REFVAL02
        ''{
            "tx_desc":"E-commerce Purchase",
            "com_code":"ECOM_PUR",
            "p_code":"ECOM_PUR",
            "ccycode":"THB"
        }'', -- REFVAL10

        ''E-commerce Purchase'', -- CHAR02
        0.00, -- NUM03
        0.00, -- NUM04
        CAST(GETDATE() AS DATE), -- DATE01
        GETDATE(), -- DATE2
        GETUTCDATE(), -- DATE03
		(SELECT TOP 1 CODEID AS tx_channel FROM D_CODETYPE WHERE CODETYPE = ''TXCHANNEL'' AND RECID IN (26,27) ORDER BY NEWID() FOR JSON PATH), -- REFVAL05
		REPLACE(LOWER(NEWID()),''-'','''')
    );

    COMMIT TRAN;

    SET @count = @count + 1;
END;
', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_TXN_BDY_EXEC]    Script Date: 7/24/2025 8:35:36 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_TXN_BDY_EXEC', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_ADD_TXN_BDY_EXEC
USE [KCARD]
GO

BEGIN TRAN;

UPDATE D_CDSTM
SET
    TRACE       = ''95'' + RIGHT(''0000000000'' + CAST(RECID AS NVARCHAR), 10),
    TNO         = FORMAT(GETDATE(), ''yyyyMMdd'') + RIGHT(''0000000000'' + CAST(RECID AS NVARCHAR), 10),
    XREF        = FORMAT(GETDATE(), ''yyyyMMdd'') + LOWER(REPLACE(NEWID(), ''-'', '''')),
    TMNCODE     = ''{}'',
    TMNID       = ''{}'',
    TMNTYPE     = ''{"dtype":"mobile","dtype":"web"}'',
	-- BANKID		= JSON_VALUE(REFVAL02, ''$[0].BANKID''),
    BRANCHCODE  = JSON_VALUE(REFVAL01, ''$[0].BRANCHCODE''),
    CARDNO      = JSON_VALUE(REFVAL01, ''$[0].CARDNO''),
    CUSCODE     = JSON_VALUE(REFVAL01, ''$[0].CUSCODE''),
    CUSACCR     = JSON_VALUE(REFVAL01, ''$[0].CUSACC''),
    CARDTYPE    = JSON_VALUE(REFVAL01, ''$[0].CARDTYPE''),
    CUSMOBILE   = ''-'',         -- Placeholder, to be updated if needed
    INCACNO     = ''{"ac_info":{"sercode":"ECOM_PUR","gl_acno":[{"ac_no":"21007003"}],"txcode":"0015","ccy_id":"THB"}}'',        -- Empty JSON as string
    RRN         = JSON_VALUE(REFVAL01, ''$[0].RRN''),
    CARDBIN     = JSON_VALUE(REFVAL01, ''$[0].CARDBIN'')
WHERE 
    TXCODE = ''0015''
    AND TRACE IS NULL;

COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_UPD_TXN_STS_EXEC]    Script Date: 7/24/2025 8:35:36 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_UPD_TXN_STS_EXEC', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_UPD_TXN_STS_EXEC
USE [KCARD]
GO

BEGIN TRAN;

UPDATE D_CDSTM
SET 
    STS = CASE 
             WHEN TXSTS = ''C'' THEN ''C''
             WHEN TXSTS = ''F'' THEN ''F''
          END,

    ERRCODE = CASE 
                 WHEN TXSTS = ''C'' THEN ''S001''
                 WHEN TXSTS = ''F'' THEN (
                     SELECT TOP 1 ERRCODE 
                     FROM D_ERRORCODE 
                     WHERE LEFT(ERRCODE, 1) = ''E'' 
                     ORDER BY NEWID()
                 )
             END,

    REFVAL09 = CASE 
                  WHEN TXSTS = ''C'' THEN ''Transaction Success''
                  WHEN TXSTS = ''F'' THEN ''Transaction Fail''
               END,

    USRAPPR = CASE 
                 WHEN TXSTS = ''C'' THEN ''8073c0a9-3cc8-40a9-b3e8-214a1876450b''
                 WHEN TXSTS = ''F'' THEN NULL
              END,

    WFCODE = CASE 
                WHEN TXSTS = ''C'' THEN ''WF_PAY|WF_SUC''
                WHEN TXSTS = ''F'' THEN ''WF_PAY|WF_ERR''
             END
WHERE 
    TXCODE = ''0015''
    AND STS IS NULL;

COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_OTP_INFO_EXEC]    Script Date: 7/24/2025 8:35:36 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_OTP_INFO_EXEC', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_ADD_OTP_INFO_EXEC
USE [KCARD]
GO

BEGIN TRAN;
INSERT INTO D_OTPINFO(
[TXREFID],[TXDT],[COMCODE],[XREF],[OTPCODE],[OTPSTS],[REQBODY],[CREATEDT]
)
SELECT 
TXREFID,TXDT,CONCAT(TRANCODE,''/'',COMCODE),XREF,CHAR01,
CASE WHEN STS = ''C'' THEN ''U''
ELSE ''E'' END AS OTPSTS,
REFVAL01,
GETUTCDATE()
FROM  D_CDSTM
WHERE TXCODE = ''0015''
  AND REFVAL04 IS NULL;
COMMIT TRAN;

-- update D_CDSTM
BEGIN TRAN;
UPDATE D_CDSTM
SET REFVAL04 = CONCAT(''{"otp_code":"'',CHAR01,''","sts":"S"}''),
CHAR39 = CASE 
                WHEN TXSTS = ''C'' THEN ''OTP is used''
                WHEN TXSTS = ''F'' THEN ''OTP is expired''
            END
WHERE TXCODE = ''0015''
  AND REFVAL04 IS NULL;
COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_UPD_TXN_BAL_EXEC]    Script Date: 7/24/2025 8:35:36 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_UPD_TXN_BAL_EXEC', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_UPD_TXN_BAL_EXEC
USE [KCARD]
GO

BEGIN TRAN;

UPDATE D_CDSTM
SET 
    NUM01 = CASE 
                WHEN TXSTS = ''C'' THEN AMT
                WHEN TXSTS = ''F'' THEN 0.00
            END,

    NUM02 = CASE 
                WHEN TXSTS = ''C'' THEN AMT
                WHEN TXSTS = ''F'' THEN 0.00
            END,
	 NUM03 = CASE 
                WHEN TXSTS = ''C'' THEN FEEVAL01
                WHEN TXSTS = ''F'' THEN 0.00
            END,
	 NUM04 = CASE 
                WHEN TXSTS = ''C'' THEN FEEVAL02
                WHEN TXSTS = ''F'' THEN 0.00
            END,

    NUM08 = CASE 
                WHEN TXSTS = ''C'' THEN AMT 
                WHEN TXSTS = ''F'' THEN 0.00
            END,

    NUM09 = CASE 
                WHEN TXSTS = ''C'' THEN AMT
                WHEN TXSTS = ''F'' THEN 0.00
            END,

    NUM10 = CASE 
                WHEN TXSTS = ''C'' THEN AMT
                WHEN TXSTS = ''F'' THEN 0.00
            END,

    CHAR03 = CASE 
                 WHEN TXSTS = ''C'' THEN CONCAT(''{"txn_bal":"'', AMT, ''","ccyid":"THB"}'')
                 WHEN TXSTS = ''F'' THEN ''{}''
             END,

    DVALUEDT = CAST(GETDATE() AS DATE),
    TXUPDATEDT = GETDATE()
WHERE 
    TXCODE = ''0015''
    AND NUM01 IS NULL;

COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_API_STM_EXEC]    Script Date: 7/24/2025 8:35:36 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_API_STM_EXEC', 
		@step_id=6, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_ADD_API_STM_EXEC
USE [KCARD]
GO

-- Insert into D_APISTM
BEGIN TRAN;

INSERT INTO D_APISTM (
	TXDT, TXREFID, TRACE, TXTIME, STATUS,
	MID, TXCODE, BCODE, PAYCODE, DVALUEDT,
	TXUPDATEDT, COMCODE, ISONUS, ISOFFUS, PCODE,
	RRN, CARDBIN, CHAR01, CHAR02, CHAR03,
	CHAR04, CHAR05, CHAR06, CHAR07, CHAR08,
	CHAR09, CHAR10, NUM01, NUM02, NUM03,
	ID, TRNDT, DATE01, CHAR11, TRANCODE
)
SELECT 
	TXDT, TXREFID, TRACE, TXTIME, STS,
	MID, TXCODE, BCODE, PAYCODE, DVALUEDT,
	TXUPDATEDT, COMCODE, ISONUS, ISOFFUS, PCODE,
	RRN, CARDBIN, BANKID, BRANCHCODE, SWIFTCODE,
	CUSACCR, CUSCODE, CARDNO, WFCODE, DESCS,
	REFVAL09, REFVAL10, AMT, FEEVAL01, FEEVAL02,
	ID, DATE03, DATE01, ''/v1/kcard/exec/wfstm/{txrefid}'', TRANCODE
FROM D_CDSTM
WHERE TXCODE = ''0015''
  AND CHAR10 IS NULL;

COMMIT TRAN;

-- Update D_CDSTM after insert
BEGIN TRAN;

UPDATE D_CDSTM
SET
	CHAR10 = ''Import D_APISTM'',
	CHAR11 = ''{"obj_code":"D_APISTM","action_type":"INSERT_API_STM","sts":"SUCCESS"}'',
	CHAR12 = CONCAT(TXREFID, '' import into D_APISTM''),
	CHAR13 = ''Import API Statement Success.'',
	CHAR14 = ''{"object":"D_APISTM"}''
WHERE TXCODE = ''0015''
  AND CHAR10 IS NULL;

COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_WFW_STM_EXEC]    Script Date: 7/24/2025 8:35:36 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_WFW_STM_EXEC', 
		@step_id=7, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
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
    FROM D_CDSTM 
    WHERE CHAR20 IS NULL AND TXCODE = ''0015'';

OPEN row_cursor;
FETCH NEXT FROM row_cursor INTO @ID;

WHILE @@FETCH_STATUS = 0
BEGIN
    INSERT INTO D_WFSTM (REQUESTMSG)
    SELECT 
        (SELECT * 
         FROM D_CDSTM
         WHERE RECID = @ID AND CHAR20 IS NULL AND TXCODE = ''0015''
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
    WFCODE      = JSON_VALUE(REQUESTMSG, ''$.WFCODE''),
    WFSTS       = JSON_VALUE(REQUESTMSG, ''$.WFSTS''),
    WFEXDT      = JSON_VALUE(REQUESTMSG, ''$.TXDT'')
WHERE TXCODE IS NULL;

COMMIT TRAN;

-- Step 3: Log import into D_CDSTM
BEGIN TRAN;

UPDATE D_CDSTM
SET 
    CHAR20 = ''Import D_WFSTM Done'',
    CHAR21 = CASE 
                WHEN STS = ''C'' THEN CONCAT(TXREFID, '' Workflow Exec Success'')
                WHEN STS = ''F'' THEN CONCAT(TXREFID, '' Workflow Exec Fail'')
             END,
    CHAR22 = ''Import D_WFSTM'',
    CHAR23 = ''{"obj_code":"D_WFSTM","action_type":"INSERT_WF_STM","sts":"SUCCESS"}'',
    CHAR24 = CONCAT(TXREFID, '' import into D_WFSTM''),
    CHAR25 = ''Import WorkFlow Statement Success.'',
    CHAR26 = ''{"object":"D_WFSTM"}''
WHERE CHAR20 IS NULL 
  AND TXCODE = ''0015'';

COMMIT TRAN;
GO', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_COM_TXN_INFO_EXEC]    Script Date: 7/24/2025 8:35:36 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_COM_TXN_INFO_EXEC', 
		@step_id=8, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_COM_TXN_INFO_EXEC
USE [KCARD];
GO

BEGIN TRAN;

UPDATE D_CDSTM
SET
    CHAR30 = CONCAT(TXREFID, ''/'', TRACE, ''/'', TNO),
    CHAR31 = CONCAT(XREF, '' External Ref No''),
    CHAR32 = CONCAT(''{"tno":"'', TNO, ''"}''),
    CHAR33 = REFVAL01,
    CHAR40 = CONCAT(''{"txrefid":"'', TXREFID, ''"}''),
    CHAR45 = REFVAL10,
    CHAR41 = REFVAL09,
    CHAR50 = DESCS,
	REFVAL06 = CONCAT(''EXT_PAY_REF '',TNO)
WHERE 
    CHAR30 IS NULL 
    AND TXCODE = ''0015'';

COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'B_ECOM_SAL_TXN_EXEC_AM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=5, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20250722, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=55959, 
		@schedule_uid=N'e920f7f0-30d8-496d-9e45-76b159e3a799'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'B_ECOM_SAL_TXN_EXEC_PM', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=4, 
		@freq_subday_interval=8, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20250722, 
		@active_end_date=99991231, 
		@active_start_time=60000, 
		@active_end_time=235959, 
		@schedule_uid=N'80323fe3-2bc9-43a7-9510-600108eaab95'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


