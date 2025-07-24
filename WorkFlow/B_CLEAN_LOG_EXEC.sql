USE [msdb]
GO

/****** Object:  Job [B_CLEAN_LOG_EXEC]    Script Date: 7/24/2025 8:34:49 PM ******/
BEGIN TRANSACTION
DECLARE @ReturnCode INT
SELECT @ReturnCode = 0
/****** Object:  JobCategory [Data Collector]    Script Date: 7/24/2025 8:34:49 PM ******/
IF NOT EXISTS (SELECT name FROM msdb.dbo.syscategories WHERE name=N'Data Collector' AND category_class=1)
BEGIN
EXEC @ReturnCode = msdb.dbo.sp_add_category @class=N'JOB', @type=N'LOCAL', @name=N'Data Collector'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback

END

DECLARE @jobId BINARY(16)
EXEC @ReturnCode =  msdb.dbo.sp_add_job @job_name=N'B_CLEAN_LOG_EXEC', 
		@enabled=1, 
		@notify_level_eventlog=0, 
		@notify_level_email=0, 
		@notify_level_netsend=0, 
		@notify_level_page=0, 
		@delete_level=0, 
		@description=N'Job Clean Log/System Maintainence', 
		@category_name=N'Data Collector', 
		@owner_login_name=N'KASIKORNBANK\Administrator', @job_id = @jobId OUTPUT
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_ADD_SCH_CFG_EXEC]    Script Date: 7/24/2025 8:34:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_ADD_SCH_CFG_EXEC', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'-- J_ADD_SCH_CFG_EXEC
USE [KCARD]
GO

-- clear old data
TRUNCATE TABLE [D_SCHEDULECONFIGURATION];

-- add schdule
BEGIN TRAN;
INSERT INTO D_SCHEDULECONFIGURATION
(SCHEDULEID,SCHDULECODE,SCHEDULENAME,DESCRIPTION,STEPCODE,STEPORD,SCHBODY,STATUS,MAKER,APPROVER,CREATEDT,
SCHEDULEVER,FREQUENCY,INTERVALTYPE,SCHTYPE,SCHPARA,INTERVAL)
SELECT 
LOWER(A.job_id),
REPLACE(A.name,''B_'',''JOB_''),
A.name,
A.description,
B.step_name,
B.step_id,
B.command,
''A'',
''1a596afb-0de3-4bbc-b152-d0d4dbebd412'',
''1a596afb-0de3-4bbc-b152-d0d4dbebd412'',
GETUTCDATE(),
A.version_number,
''DAILY'',
''MINUTE'',
''JOB_TXN_EXEC'',
''AM|PM'',
1
FROM msdb.dbo.sysjobs A JOIN msdb.dbo.sysjobsteps B
ON A.job_id = B.job_id
WHERE description <> ''No description available.''
COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_MOV_HIS_CAD_STM_EXEC]    Script Date: 7/24/2025 8:34:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_MOV_HIS_CAD_STM_EXEC', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [KCARD]
GO

-- Declare variable to store row count
DECLARE @MovedRowCount INT;

-- Move Historical Data
BEGIN TRANSACTION;

-- Insert the data into R_CDSTM from D_CDSTM based on the conditions
;WITH CTE_Transaction AS (
    SELECT 
	   [TXDT]
      ,[TXREFID]
      ,[TRACE]
      ,[TXTIME]
      ,[MID]
      ,[TNO]
      ,[XREF]
      ,[USRID]
      ,[USRAPPR]
      ,[TMNID]
      ,[TMNCODE]
      ,[TMNTYPE]
      ,[TXCODE]
      ,[TRANCODE]
      ,[BCODE]
      ,[PAYCODE]
      ,[PAYREFNO]
      ,[DVALUEDT]
      ,[TXUPDATEDT]
      ,[BANKID]
      ,[BRANCHCODE]
      ,[SWIFTCODE]
      ,[ID]
      ,[CARDNO]
      ,[CARDTYPE]
      ,[CUSCODE]
      ,[CUSACCR]
      ,[CUSMOBILE]
      ,[MERCHANTID]
      ,[NOTIFYMAIL]
      ,[INCACNO]
      ,[AMT]
      ,[CCYCODE]
      ,[REGION]
      ,[FEECODE]
      ,[FEEVAL01]
      ,[FEEVAL02]
      ,[COMCODE]
      ,[ISONUS]
      ,[ISOFFUS]
      ,[PCODE]
      ,[RRN]
      ,[CARDBIN]
      ,[TRANTYPE]
      ,[ISOFFLINE]
      ,[ISONLINE]
      ,[RSTS]
      ,[WFSTS]
      ,[TXSTS]
      ,[STS]
      ,[WFCODE]
      ,[ERRCODE]
      ,[DESCS]
      ,[REFVAL01]
      ,[REFVAL02]
      ,[REFVAL03]
      ,[REFVAL04]
      ,[REFVAL05]
      ,[REFVAL06]
      ,[REFVAL07]
      ,[REFVAL08]
      ,[REFVAL09]
      ,[REFVAL10]
      ,[CHAR01]
      ,[CHAR02]
      ,[CHAR03]
      ,[CHAR04]
      ,[CHAR05]
      ,[CHAR06]
      ,[CHAR07]
      ,[CHAR08]
      ,[CHAR09]
      ,[CHAR10]
      ,[CHAR11]
      ,[CHAR12]
      ,[CHAR13]
      ,[CHAR14]
      ,[CHAR15]
      ,[CHAR16]
      ,[CHAR17]
      ,[CHAR18]
      ,[CHAR19]
      ,[CHAR20]
      ,[CHAR21]
      ,[CHAR22]
      ,[CHAR23]
      ,[CHAR24]
      ,[CHAR25]
      ,[CHAR26]
      ,[CHAR27]
      ,[CHAR28]
      ,[CHAR29]
      ,[CHAR30]
      ,[CHAR31]
      ,[CHAR32]
      ,[CHAR33]
      ,[CHAR34]
      ,[CHAR35]
      ,[CHAR36]
      ,[CHAR37]
      ,[CHAR38]
      ,[CHAR39]
      ,[CHAR40]
      ,[CHAR41]
      ,[CHAR42]
      ,[CHAR43]
      ,[CHAR44]
      ,[CHAR45]
      ,[CHAR46]
      ,[CHAR47]
      ,[CHAR48]
      ,[CHAR49]
      ,[CHAR50]
      ,[NUM01]
      ,[NUM02]
      ,[NUM03]
      ,[NUM04]
      ,[NUM05]
      ,[NUM06]
      ,[NUM07]
      ,[NUM08]
      ,[NUM09]
      ,[NUM10]
      ,[DATE01]
      ,[DATE2]
      ,[DATE03]
      ,[DATE04]
      ,[DATE05]
      ,[DATE06]
  FROM [KCARD].[dbo].[D_CDSTM]
  WHERE CAST(DVALUEDT AS date) < CAST(GETDATE() as date)
)
-- Insert the selected records into R_CDSTM and also delete from D_CDSTM
DELETE CTE_Transaction
OUTPUT 
	   DELETED.[TXDT]
      ,DELETED.[TXREFID]
      ,DELETED.[TRACE]
      ,DELETED.[TXTIME]
      ,DELETED.[MID]
      ,DELETED.[TNO]
      ,DELETED.[XREF]
      ,DELETED.[USRID]
      ,DELETED.[USRAPPR]
      ,DELETED.[TMNID]
      ,DELETED.[TMNCODE]
      ,DELETED.[TMNTYPE]
      ,DELETED.[TXCODE]
      ,DELETED.[TRANCODE]
      ,DELETED.[BCODE]
      ,DELETED.[PAYCODE]
      ,DELETED.[PAYREFNO]
      ,DELETED.[DVALUEDT]
      ,DELETED.[TXUPDATEDT]
      ,DELETED.[BANKID]
      ,DELETED.[BRANCHCODE]
      ,DELETED.[SWIFTCODE]
      ,DELETED.[ID]
      ,DELETED.[CARDNO]
      ,DELETED.[CARDTYPE]
      ,DELETED.[CUSCODE]
      ,DELETED.[CUSACCR]
      ,DELETED.[CUSMOBILE]
      ,DELETED.[MERCHANTID]
      ,DELETED.[NOTIFYMAIL]
      ,DELETED.[INCACNO]
      ,DELETED.[AMT]
      ,DELETED.[CCYCODE]
      ,DELETED.[REGION]
      ,DELETED.[FEECODE]
      ,DELETED.[FEEVAL01]
      ,DELETED.[FEEVAL02]
      ,DELETED.[COMCODE]
      ,DELETED.[ISONUS]
      ,DELETED.[ISOFFUS]
      ,DELETED.[PCODE]
      ,DELETED.[RRN]
      ,DELETED.[CARDBIN]
      ,DELETED.[TRANTYPE]
      ,DELETED.[ISOFFLINE]
      ,DELETED.[ISONLINE]
      ,DELETED.[RSTS]
      ,DELETED.[WFSTS]
      ,DELETED.[TXSTS]
      ,DELETED.[STS]
      ,DELETED.[WFCODE]
      ,DELETED.[ERRCODE]
      ,DELETED.[DESCS]
      ,DELETED.[REFVAL01]
      ,DELETED.[REFVAL02]
      ,DELETED.[REFVAL03]
      ,DELETED.[REFVAL04]
      ,DELETED.[REFVAL05]
      ,DELETED.[REFVAL06]
      ,DELETED.[REFVAL07]
      ,DELETED.[REFVAL08]
      ,DELETED.[REFVAL09]
      ,DELETED.[REFVAL10]
      ,DELETED.[CHAR01]
      ,DELETED.[CHAR02]
      ,DELETED.[CHAR03]
      ,DELETED.[CHAR04]
      ,DELETED.[CHAR05]
      ,DELETED.[CHAR06]
      ,DELETED.[CHAR07]
      ,DELETED.[CHAR08]
      ,DELETED.[CHAR09]
      ,DELETED.[CHAR10]
      ,DELETED.[CHAR11]
      ,DELETED.[CHAR12]
      ,DELETED.[CHAR13]
      ,DELETED.[CHAR14]
      ,DELETED.[CHAR15]
      ,DELETED.[CHAR16]
      ,DELETED.[CHAR17]
      ,DELETED.[CHAR18]
      ,DELETED.[CHAR19]
      ,DELETED.[CHAR20]
      ,DELETED.[CHAR21]
      ,DELETED.[CHAR22]
      ,DELETED.[CHAR23]
      ,DELETED.[CHAR24]
      ,DELETED.[CHAR25]
      ,DELETED.[CHAR26]
      ,DELETED.[CHAR27]
      ,DELETED.[CHAR28]
      ,DELETED.[CHAR29]
      ,DELETED.[CHAR30]
      ,DELETED.[CHAR31]
      ,DELETED.[CHAR32]
      ,DELETED.[CHAR33]
      ,DELETED.[CHAR34]
      ,DELETED.[CHAR35]
      ,DELETED.[CHAR36]
      ,DELETED.[CHAR37]
      ,DELETED.[CHAR38]
      ,DELETED.[CHAR39]
      ,DELETED.[CHAR40]
      ,DELETED.[CHAR41]
      ,DELETED.[CHAR42]
      ,DELETED.[CHAR43]
      ,DELETED.[CHAR44]
      ,DELETED.[CHAR45]
      ,DELETED.[CHAR46]
      ,DELETED.[CHAR47]
      ,DELETED.[CHAR48]
      ,DELETED.[CHAR49]
      ,DELETED.[CHAR50]
      ,DELETED.[NUM01]
      ,DELETED.[NUM02]
      ,DELETED.[NUM03]
      ,DELETED.[NUM04]
      ,DELETED.[NUM05]
      ,DELETED.[NUM06]
      ,DELETED.[NUM07]
      ,DELETED.[NUM08]
      ,DELETED.[NUM09]
      ,DELETED.[NUM10]
      ,DELETED.[DATE01]
      ,DELETED.[DATE2]
      ,DELETED.[DATE03]
      ,DELETED.[DATE04]
      ,DELETED.[DATE05]
      ,DELETED.[DATE06]
INTO R_CDSTM;

-- Capture how many rows were moved
SET @MovedRowCount = @@ROWCOUNT;

-- Insert clear log
INSERT INTO dbo.D_CLEANLOG(
	TXDT,
	CLEANDT,
	DESCS,
	FROMSRC,
	TOSRC,
	TXBODY,
	STS,
	RESULT,
	RESPMSG,
	REQMSG
)
VALUES (
	GETDATE(),
	CAST(GETDATE()-1 AS date),
	CONCAT(''Move Data from D_CDSTM to R_CDSTM with RowCount '',@MovedRowCount),
	''D_CDSTM'',
	''R_CDSTM'',
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [ACTIONCODE],
    GETDATE() AS [TXDT],
    @MovedRowCount AS [ROWCNT]
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	),
	''S'',
	@MovedRowCount,
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [DESC],
    GETDATE() AS [TXDT],
    NEWID() AS [uuid]
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	),
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [DESC],
    GETDATE() AS [TXDT],
    NEWID() AS [uuid]
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	)
);

COMMIT TRANSACTION;

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_MOV_HIS_API_STM_EXEC]    Script Date: 7/24/2025 8:34:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_MOV_HIS_API_STM_EXEC', 
		@step_id=3, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [KCARD]
GO

-- Declare variable to store row count
DECLARE @MovedRowCount INT;

-- Move Historical Data
BEGIN TRANSACTION;

-- Insert the data into R_APISTM from D_APISTM based on the conditions
;WITH CTE_Transaction AS (
    SELECT 
	   [TXDT]
      ,[TXREFID]
      ,[TRACE]
      ,[TXTIME]
      ,[STATUS]
      ,[MID]
      ,[TXCODE]
      ,[TRANCODE]
      ,[BCODE]
      ,[PAYCODE]
      ,[DVALUEDT]
      ,[TXUPDATEDT]
      ,[COMCODE]
      ,[ISONUS]
      ,[ISOFFUS]
      ,[PCODE]
      ,[RRN]
      ,[CARDBIN]
      ,[CHAR01]
      ,[CHAR02]
      ,[CHAR03]
      ,[CHAR04]
      ,[CHAR05]
      ,[CHAR06]
      ,[CHAR07]
      ,[CHAR08]
      ,[CHAR09]
      ,[CHAR10]
      ,[CHAR11]
      ,[CHAR12]
      ,[CHAR13]
      ,[CHAR14]
      ,[CHAR15]
      ,[CHAR16]
      ,[CHAR17]
      ,[CHAR18]
      ,[CHAR19]
      ,[CHAR20]
      ,[NUM01]
      ,[NUM02]
      ,[NUM03]
      ,[NUM04]
      ,[NUM05]
      ,[NUM06]
      ,[NUM07]
      ,[NUM08]
      ,[NUM09]
      ,[NUM10]
      ,[DATE01]
      ,[DATE2]
      ,[DATE03]
      ,[DATE04]
      ,[DATE05]
      ,[DATE06]
      ,[ID]
      ,[TRNDT]
  FROM [KCARD].[dbo].[D_APISTM]
  WHERE CAST(DVALUEDT AS date) < CAST(GETDATE() as date)
)
-- Insert the selected records into R_APISTM and also delete from D_APISTM
DELETE CTE_Transaction
OUTPUT 
	   DELETED.[TXDT]
      ,DELETED.[TXREFID]
      ,DELETED.[TRACE]
      ,DELETED.[TXTIME]
      ,DELETED.[STATUS]
      ,DELETED.[MID]
      ,DELETED.[TXCODE]
      ,DELETED.[TRANCODE]
      ,DELETED.[BCODE]
      ,DELETED.[PAYCODE]
      ,DELETED.[DVALUEDT]
      ,DELETED.[TXUPDATEDT]
      ,DELETED.[COMCODE]
      ,DELETED.[ISONUS]
      ,DELETED.[ISOFFUS]
      ,DELETED.[PCODE]
      ,DELETED.[RRN]
      ,DELETED.[CARDBIN]
      ,DELETED.[CHAR01]
      ,DELETED.[CHAR02]
      ,DELETED.[CHAR03]
      ,DELETED.[CHAR04]
      ,DELETED.[CHAR05]
      ,DELETED.[CHAR06]
      ,DELETED.[CHAR07]
      ,DELETED.[CHAR08]
      ,DELETED.[CHAR09]
      ,DELETED.[CHAR10]
      ,DELETED.[CHAR11]
      ,DELETED.[CHAR12]
      ,DELETED.[CHAR13]
      ,DELETED.[CHAR14]
      ,DELETED.[CHAR15]
      ,DELETED.[CHAR16]
      ,DELETED.[CHAR17]
      ,DELETED.[CHAR18]
      ,DELETED.[CHAR19]
      ,DELETED.[CHAR20]
      ,DELETED.[NUM01]
      ,DELETED.[NUM02]
      ,DELETED.[NUM03]
      ,DELETED.[NUM04]
      ,DELETED.[NUM05]
      ,DELETED.[NUM06]
      ,DELETED.[NUM07]
      ,DELETED.[NUM08]
      ,DELETED.[NUM09]
      ,DELETED.[NUM10]
      ,DELETED.[DATE01]
      ,DELETED.[DATE2]
      ,DELETED.[DATE03]
      ,DELETED.[DATE04]
      ,DELETED.[DATE05]
      ,DELETED.[DATE06]
      ,DELETED.[ID]
      ,DELETED.[TRNDT]
INTO R_APISTM;

-- Capture how many rows were moved
SET @MovedRowCount = @@ROWCOUNT;

-- Insert clear log
INSERT INTO dbo.D_CLEANLOG(
	TXDT,
	CLEANDT,
	DESCS,
	FROMSRC,
	TOSRC,
	TXBODY,
	STS,
	RESULT,
	RESPMSG,
	REQMSG
)
VALUES (
	GETDATE(),
	CAST(GETDATE()-1 AS date),
	CONCAT(''Move Data from D_APISTM to R_APISTM with RowCount '',@MovedRowCount),
	''D_APISTM'',
	''R_APISTM'',
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [ACTIONCODE],
    GETDATE() AS [TXDT],
    @MovedRowCount AS [ROWCNT]
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	),
	''S'',
	@MovedRowCount,
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [DESC],
    GETDATE() AS [TXDT],
    NEWID() AS [uuid]
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	),
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [DESC],
    GETDATE() AS [TXDT],
    NEWID() AS [uuid]
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	)
);

COMMIT TRANSACTION;

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [J_MOV_HIS_WFL_STM_EXEC]    Script Date: 7/24/2025 8:34:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'J_MOV_HIS_WFL_STM_EXEC', 
		@step_id=4, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'USE [KCARD]
GO

-- Declare variable to store row count
DECLARE @MovedRowCount INT;

-- Move Historical Data
BEGIN TRANSACTION;

-- Insert the data into R_WFSTM from D_WFSTM based on the conditions
;WITH CTE_Transaction AS (
    SELECT 
	   [TXREFID]
      ,[TXDT]
      ,[TXCODE]
      ,[WFCODE]
      ,[WFBODY]
      ,[WFSTS]
      ,[REQUESTMSG]
      ,[RESPONSEMSG]
      ,[WFEXDT]
      ,[ID]
  FROM [KCARD].[dbo].[D_WFSTM]
  WHERE CAST(WFEXDT AS date) < CAST(GETDATE() as date)
)
-- Insert the selected records into R_CDSTM and also delete from D_CDSTM
DELETE CTE_Transaction
OUTPUT 
	   DELETED.[TXREFID]
      ,DELETED.[TXDT]
      ,DELETED.[TXCODE]
      ,DELETED.[WFCODE]
      ,DELETED.[WFBODY]
      ,DELETED.[WFSTS]
      ,DELETED.[REQUESTMSG]
      ,DELETED.[RESPONSEMSG]
      ,DELETED.[WFEXDT]
      ,DELETED.[ID]
INTO R_WFSTM;

-- Capture how many rows were moved
SET @MovedRowCount = @@ROWCOUNT;

-- Insert clear log
INSERT INTO dbo.D_CLEANLOG(
	TXDT,
	CLEANDT,
	DESCS,
	FROMSRC,
	TOSRC,
	TXBODY,
	STS,
	RESULT,
	RESPMSG,
	REQMSG
)
VALUES (
	GETDATE(),
	CAST(GETDATE()-1 AS date),
	CONCAT(''Move Data from D_WFSTM to R_WFSTM with RowCount '',@MovedRowCount),
	''D_WFSTM'',
	''R_WFSTM'',
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [ACTIONCODE],
    GETDATE() AS [TXDT],
    @MovedRowCount AS [ROWCNT]
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	),
	''S'',
	@MovedRowCount,
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [DESC],
    GETDATE() AS [TXDT],
    NEWID() AS [uuid]
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	),
	(
	SELECT 
    CAST(GETDATE() AS date) AS [DATE],
    ''Clean Log'' AS [DESC],
    GETDATE() AS [TXDT],
    NEWID() AS [uuid]
	FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
	)
);

COMMIT TRANSACTION;

', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
/****** Object:  Step [B_COL_FEE_SET_EXEC]    Script Date: 7/24/2025 8:34:49 PM ******/
EXEC @ReturnCode = msdb.dbo.sp_add_jobstep @job_id=@jobId, @step_name=N'B_COL_FEE_SET_EXEC', 
		@step_id=5, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_success_step_id=0, 
		@on_fail_action=2, 
		@on_fail_step_id=0, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N'TSQL', 
		@command=N'--DPT_ATM_WTD_OFFUS
--DPT_ECOM_PUR
--DPT_EDC_PAY
--DPT_POS_PAY
-- DPT_ATM_BIL_PAY
USE [KCARD]
GO

-- declare variable
DECLARE @fileid1 VARCHAR(50) = LOWER(NEWID()) -- DPT_ATM_WTD_OFFUS
DECLARE @fileid2 VARCHAR(50) = LOWER(NEWID()) -- DPT_ECOM_PUR
DECLARE @fileid3 VARCHAR(50) = LOWER(NEWID()) -- DPT_EDC_PAY
DECLARE @fileid4 VARCHAR(50) = LOWER(NEWID()) -- DPT_POS_PAY
DECLARE @fileid5 VARCHAR(50) = LOWER(NEWID()) -- DPT_ATM_BIL_PAY
DECLARE @filename1 VARCHAR(100) = CONCAT(''WOF_'',''COLLECT_FEE_'',FORMAT(GETDATE(),''yyyymmdd''),''000000.xml'')
DECLARE @filename2 VARCHAR(100) = CONCAT(''ECOM_'',''COLLECT_FEE_'',FORMAT(GETDATE(),''yyyymmdd''),''000000.xml'')
DECLARE @filename3 VARCHAR(100) = CONCAT(''EDC_'',''COLLECT_FEE_'',FORMAT(GETDATE(),''yyyymmdd''),''000000.xml'')
DECLARE @filename4 VARCHAR(100) = CONCAT(''POS_'',''COLLECT_FEE_'',FORMAT(GETDATE(),''yyyymmdd''),''000000.xml'')
DECLARE @filename5 VARCHAR(100) = CONCAT(''BILLPAY_'',''COLLECT_FEE_'',FORMAT(GETDATE(),''yyyymmdd''),''000000.xml'')
DECLARE @filests VARCHAR(15) = ''SUCCESS''
DECLARE @sts VARCHAR(15) = ''C''
DECLARE @filedt DATETIME = CAST(GETDATE()-1 AS date)
DECLARE @usrid VARCHAR(50) = ''b406ee77-2df5-4f25-8811-a9129c3b66fd''
DECLARE @rowcnt1 INT = 
(SELECT COUNT(*) FROM KCARD.dbo.R_CDSTM WHERE TRANCODE = ''DPT_ATM_WTD_OFFUS''  -- DPT_ATM_WTD_OFFUS
AND STS = ''C'' AND CAST(DVALUEDT AS date) < CAST(GETDATE() as date))
DECLARE @rowcnt2 INT = 
(SELECT COUNT(*) FROM KCARD.dbo.R_CDSTM WHERE TRANCODE = ''DPT_ECOM_PUR'' -- DPT_ECOM_PUR
AND STS = ''C'' AND CAST(DVALUEDT AS date) < CAST(GETDATE() as date))
DECLARE @rowcnt3 INT = 
(SELECT COUNT(*) FROM KCARD.dbo.R_CDSTM WHERE TRANCODE = ''DPT_EDC_PAY'' -- DPT_EDC_PAY
AND STS = ''C'' AND CAST(DVALUEDT AS date) < CAST(GETDATE() as date))
DECLARE @rowcnt4 INT = 
(SELECT COUNT(*) FROM KCARD.dbo.R_CDSTM WHERE TRANCODE = ''DPT_POS_PAY'' -- DPT_POS_PAY
AND STS = ''C'' AND CAST(DVALUEDT AS date) < CAST(GETDATE() as date))
DECLARE @rowcnt5 INT = 
(SELECT COUNT(*) FROM KCARD.dbo.R_CDSTM WHERE TRANCODE = ''DPT_ATM_BIL_PAY'' -- DPT_ATM_BIL_PAY
AND STS = ''C'' AND CAST(DVALUEDT AS date) < CAST(GETDATE() as date))

-- insert d_fileinfo
BEGIN TRAN;
INSERT INTO [KCARD].[dbo].[D_FILEINFO]
(FILEID,FILENAME,FILESTS,FILEDT,USRID,ROWCNT,STS,DESCS,FILETYPE)
VALUES
(
@fileid1,@filename1,@filests,@filedt,@usrid,@rowcnt1,@sts,''Collect Fee/Cash Withdrawal – Off-Us ATM'',''DPT_ATM_WTD_OFFUS''
),
(
@fileid2,@filename2,@filests,@filedt,@usrid,@rowcnt2,@sts,''Collect Fee/E-commerce Purchase'',''DPT_ECOM_PUR''
),
(
@fileid3,@filename3,@filests,@filedt,@usrid,@rowcnt3,@sts,''Collect Fee/EDC Payment'',''DPT_EDC_PAY''
),
(
@fileid4,@filename4,@filests,@filedt,@usrid,@rowcnt4,@sts,''Collect Fee/POS Payment'',''DPT_POS_PAY''
),
(
@fileid5,@filename5,@filests,@filedt,@usrid,@rowcnt5,@sts,''Collect Fee/Bill Payment'',''DPT_ATM_BIL_PAY''
)
COMMIT TRAN;

-- insert filelst
BEGIN TRAN;
INSERT INTO KCARD.dbo.D_FILELST
(FILEDT,FILEID,FILESTS,SETTLESTS,DVALUEDT,TXDT,CONSUMERNO,FILETYPE,CHAR01,
CHAR02,CHAR03,CHAR04,CHAR05,CHAR06,CHAR07,CHAR08,CHAR09,CHAR10,NUM01,NUM02,NUM03,NUM04,NUM05,NUM06,DATE01)
SELECT 
@filedt,
CASE WHEN
TRANCODE = ''DPT_ATM_WTD_OFFUS'' THEN @fileid1
WHEN
TRANCODE = ''DPT_ECOM_PUR'' THEN @fileid2
WHEN
TRANCODE = ''DPT_EDC_PAY'' THEN @fileid3
WHEN
TRANCODE = ''DPT_POS_PAY'' THEN @fileid4
WHEN
TRANCODE = ''DPT_ATM_BIL_PAY'' THEN @fileid5
END AS fileid,
@filests,
@sts,
DVALUEDT,
TXDT,
CARDNO,
TRANCODE,
XREF,
INCACNO,
FEECODE,
COMCODE,
PCODE,
CARDBIN,
DESCS,
REFVAL01,
REFVAL03,
CHAR03,
AMT,
FEEVAL01,
FEEVAL02,
NUM01,
NUM09,
NUM10,
GETUTCDATE()
FROM KCARD.dbo.R_CDSTM
WHERE TRANCODE IN (
''DPT_ATM_WTD_OFFUS'',
''DPT_ECOM_PUR'',
''DPT_EDC_PAY'',
''DPT_POS_PAY'',
''DPT_ATM_BIL_PAY''
) AND STS = ''C'' AND CAST(DVALUEDT AS date) < CAST(GETDATE() as date)
COMMIT TRAN;

-- update R_CDSTM
BEGIN TRAN;
UPDATE KCARD.dbo.R_CDSTM
SET REFVAL03 = (
SELECT 
    CAST(GETDATE()-1 as date) AS [DATE],
    ''Collect Fee Settlement'' AS [DESC],
    GETUTCDATE() AS [TXDT],
    LOWER(NEWID()) AS [uuid]
FOR JSON PATH, WITHOUT_ARRAY_WRAPPER
)WHERE TRANCODE IN (
''DPT_ATM_WTD_OFFUS'',
''DPT_ECOM_PUR'',
''DPT_EDC_PAY'',
''DPT_POS_PAY'',
''DPT_ATM_BIL_PAY''
) AND STS = ''C'' AND CAST(DVALUEDT AS date) < CAST(GETDATE() as date)
COMMIT TRAN;', 
		@database_name=N'master', 
		@flags=0
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_update_job @job_id = @jobId, @start_step_id = 1
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobschedule @job_id=@jobId, @name=N'B_CLEAN_LOG_EXEC', 
		@enabled=1, 
		@freq_type=4, 
		@freq_interval=1, 
		@freq_subday_type=1, 
		@freq_subday_interval=0, 
		@freq_relative_interval=0, 
		@freq_recurrence_factor=0, 
		@active_start_date=20250723, 
		@active_end_date=99991231, 
		@active_start_time=0, 
		@active_end_time=235959, 
		@schedule_uid=N'f0c2a27e-dbdc-46bf-be2f-8cf642fb17f9'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
EXEC @ReturnCode = msdb.dbo.sp_add_jobserver @job_id = @jobId, @server_name = N'(local)'
IF (@@ERROR <> 0 OR @ReturnCode <> 0) GOTO QuitWithRollback
COMMIT TRANSACTION
GOTO EndSave
QuitWithRollback:
    IF (@@TRANCOUNT > 0) ROLLBACK TRANSACTION
EndSave:
GO


