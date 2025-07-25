USE [master]
GO
USE [KCARD]
GO
/****** Object:  Table [dbo].[D_ACQUIREBANK]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_ACQUIREBANK](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[BANKID] [varchar](50) NULL,
	[BANKCODE] [varchar](50) NULL,
	[BANKNAME] [varchar](200) NULL,
	[STATUS] [varchar](10) NULL,
	[BANKTYPE] [varchar](50) NULL,
	[REGION] [varchar](50) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_ACQUIREBANK] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_APIM]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_APIM](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[APICODE] [varchar](200) NULL,
	[APIBODY] [varchar](max) NULL,
	[SERPORT] [varchar](10) NULL,
	[APITYPE] [varchar](50) NULL,
	[METHOD] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
	[DESCS] [nvarchar](500) NULL,
	[STS] [nvarchar](10) NULL,
 CONSTRAINT [PK_D_APIM] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_APISTM]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_APISTM](
	[RECID] [bigint] IDENTITY(1,1) NOT NULL,
	[TXDT] [datetime] NULL,
	[TXREFID] [varchar](50) NULL,
	[TRACE] [varchar](50) NULL,
	[TXTIME] [varchar](20) NULL,
	[STATUS] [varchar](10) NULL,
	[MID] [varchar](50) NULL,
	[TXCODE] [varchar](50) NULL,
	[TRANCODE] [varchar](50) NULL,
	[BCODE] [varchar](50) NULL,
	[PAYCODE] [varchar](50) NULL,
	[DVALUEDT] [datetime] NULL,
	[TXUPDATEDT] [datetime] NULL,
	[COMCODE] [varchar](50) NULL,
	[ISONUS] [varchar](10) NULL,
	[ISOFFUS] [varchar](10) NULL,
	[PCODE] [varchar](50) NULL,
	[RRN] [varchar](50) NULL,
	[CARDBIN] [varchar](50) NULL,
	[CHAR01] [varchar](200) NULL,
	[CHAR02] [varchar](200) NULL,
	[CHAR03] [varchar](200) NULL,
	[CHAR04] [varchar](200) NULL,
	[CHAR05] [varchar](200) NULL,
	[CHAR06] [varchar](200) NULL,
	[CHAR07] [varchar](200) NULL,
	[CHAR08] [varchar](200) NULL,
	[CHAR09] [varchar](200) NULL,
	[CHAR10] [varchar](200) NULL,
	[CHAR11] [varchar](200) NULL,
	[CHAR12] [varchar](200) NULL,
	[CHAR13] [varchar](200) NULL,
	[CHAR14] [varchar](200) NULL,
	[CHAR15] [varchar](200) NULL,
	[CHAR16] [varchar](200) NULL,
	[CHAR17] [varchar](200) NULL,
	[CHAR18] [varchar](200) NULL,
	[CHAR19] [varchar](200) NULL,
	[CHAR20] [varchar](200) NULL,
	[NUM01] [numeric](19, 2) NULL,
	[NUM02] [numeric](19, 2) NULL,
	[NUM03] [numeric](19, 2) NULL,
	[NUM04] [numeric](19, 2) NULL,
	[NUM05] [numeric](19, 2) NULL,
	[NUM06] [numeric](19, 2) NULL,
	[NUM07] [numeric](19, 2) NULL,
	[NUM08] [numeric](19, 2) NULL,
	[NUM09] [numeric](19, 2) NULL,
	[NUM10] [numeric](19, 2) NULL,
	[DATE01] [datetime] NULL,
	[DATE2] [datetime] NULL,
	[DATE03] [datetime] NULL,
	[DATE04] [datetime] NULL,
	[DATE05] [datetime] NULL,
	[DATE06] [datetime] NULL,
	[ID] [varchar](50) NULL,
	[TRNDT] [datetime2](7) NULL,
 CONSTRAINT [D_APISTM_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_APISTM] UNIQUE NONCLUSTERED 
(
	[ID] ASC,
	[TXREFID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_BRANCHCODE]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_BRANCHCODE](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[BRANCHID] [varchar](10) NULL,
	[BRANCHCODE] [varchar](50) NULL,
	[BRANCHNAME] [varchar](200) NULL,
	[BRANCHTYPE] [varchar](50) NULL,
	[STATUS] [varchar](10) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_BRANCHCODE] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_CARDLST]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_CARDLST](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[CUSCODE] [varchar](50) NULL,
	[BANKID] [varchar](50) NULL,
	[BRANCHCODE] [varchar](50) NULL,
	[CUSACC] [varchar](50) NULL,
	[CARDNO] [varchar](50) NULL,
	[CARDTYPE] [varchar](50) NULL,
	[CARDCAT] [varchar](50) NULL,
	[CARDSTS] [varchar](10) NULL,
	[SYNCTOKEN] [varchar](500) NULL,
	[RRN] [varchar](50) NULL,
	[CARDBIN] [varchar](50) NULL,
	[ISDEBITCD] [varchar](10) NULL,
	[ISCREDITCD] [varchar](10) NULL,
	[ISVERIFY] [varchar](10) NULL,
	[OPENDT] [datetime] NULL,
	[SYNCDT] [datetime] NULL,
	[CARDREFNO] [varchar](50) NULL,
	[CARDPIN] [varchar](50) NULL,
	[HASHPIN] [varbinary](500) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [D_CARDLST_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_CARDLST] UNIQUE NONCLUSTERED 
(
	[CUSCODE] ASC,
	[CUSACC] ASC,
	[CARDNO] ASC,
	[CARDBIN] ASC,
	[BRANCHCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_CARDTYPE]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_CARDTYPE](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[TYPEID] [varchar](50) NULL,
	[TYPECODE] [varchar](50) NULL,
	[TYPENAME] [varchar](200) NULL,
	[TYPESTS] [varchar](10) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_CARDTYPE] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_CASHACNO]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_CASHACNO](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[ACNO] [varchar](50) NULL,
	[ACDESC] [varchar](200) NULL,
	[ACSIGN] [varchar](10) NULL,
	[ACSTS] [varchar](10) NULL,
	[ACBALSIDE] [varchar](50) NULL,
	[ACTYPE] [varchar](50) NULL,
	[ROWID] [varchar](50) NULL,
 CONSTRAINT [PK_D_CASHACNO] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_CASHBACK]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_CASHBACK](
	[RECID] [bigint] IDENTITY(1,1) NOT NULL,
	[TXREFID] [varchar](50) NULL,
	[EXTREF] [varchar](50) NULL,
	[TXCODE] [varchar](50) NULL,
	[CUSCODE] [varchar](100) NULL,
	[CARDNO] [varchar](100) NULL,
	[ACNO] [varchar](50) NULL,
	[RRN] [varchar](100) NULL,
	[CARDBIN] [varchar](100) NULL,
	[CSHAMT] [decimal](19, 2) NULL,
	[FEECODE] [varchar](100) NULL,
	[FEEAMT] [decimal](19, 2) NULL,
	[STATUS] [varchar](1) NULL,
	[DESCS] [varchar](500) NULL,
	[TXDT] [datetime] NULL,
	[TMNINFO] [varchar](500) NULL,
	[XREF] [varchar](50) NULL,
	[TRANCODE] [varchar](50) NULL,
	[COMCODE] [varchar](50) NULL,
	[PCODE] [varchar](50) NULL,
	[CHAR01] [varchar](500) NULL,
	[CHAR02] [varchar](500) NULL,
	[CHAR03] [varchar](500) NULL,
	[CHAR04] [varchar](500) NULL,
	[CHAR05] [varchar](500) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_CCYLST]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_CCYLST](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[CCYID] [varchar](50) NULL,
	[CCYCODE] [varchar](50) NULL,
	[CCYNAME] [varchar](200) NULL,
	[CCYSTS] [varchar](10) NULL,
	[CREATEDT] [datetime] NULL,
	[CCYNO] [varchar](50) NULL,
 CONSTRAINT [PK_D_CCYLST] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_CDSTM]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_CDSTM](
	[RECID] [bigint] IDENTITY(1,1) NOT NULL,
	[TXDT] [datetime] NULL,
	[TXREFID] [varchar](50) NULL,
	[TRACE] [varchar](50) NULL,
	[TXTIME] [varchar](50) NULL,
	[MID] [varchar](50) NULL,
	[TNO] [varchar](50) NULL,
	[XREF] [varchar](50) NULL,
	[USRID] [varchar](50) NULL,
	[USRAPPR] [varchar](50) NULL,
	[TMNID] [varchar](50) NULL,
	[TMNCODE] [varchar](50) NULL,
	[TMNTYPE] [varchar](50) NULL,
	[TXCODE] [varchar](50) NULL,
	[TRANCODE] [varchar](50) NULL,
	[BCODE] [varchar](50) NULL,
	[PAYCODE] [varchar](50) NULL,
	[PAYREFNO] [varchar](50) NULL,
	[DVALUEDT] [datetime] NULL,
	[TXUPDATEDT] [datetime] NULL,
	[BANKID] [varchar](50) NULL,
	[BRANCHCODE] [varchar](50) NULL,
	[SWIFTCODE] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[CARDNO] [varchar](50) NULL,
	[CARDTYPE] [varchar](50) NULL,
	[CUSCODE] [varchar](50) NULL,
	[CUSACCR] [varchar](50) NULL,
	[CUSMOBILE] [varchar](50) NULL,
	[MERCHANTID] [varchar](50) NULL,
	[NOTIFYMAIL] [varchar](100) NULL,
	[INCACNO] [varchar](500) NULL,
	[AMT] [numeric](19, 2) NULL,
	[CCYCODE] [varchar](50) NULL,
	[REGION] [varchar](50) NULL,
	[FEECODE] [varchar](200) NULL,
	[FEEVAL01] [numeric](19, 2) NULL,
	[FEEVAL02] [numeric](19, 2) NULL,
	[COMCODE] [varchar](50) NULL,
	[ISONUS] [varchar](10) NULL,
	[ISOFFUS] [varchar](10) NULL,
	[PCODE] [varchar](50) NULL,
	[RRN] [varchar](50) NULL,
	[CARDBIN] [varchar](50) NULL,
	[TRANTYPE] [varchar](50) NULL,
	[ISOFFLINE] [varchar](10) NULL,
	[ISONLINE] [varchar](10) NULL,
	[RSTS] [varchar](10) NULL,
	[WFSTS] [varchar](10) NULL,
	[TXSTS] [varchar](10) NULL,
	[STS] [varchar](10) NULL,
	[WFCODE] [varchar](50) NULL,
	[ERRCODE] [varchar](50) NULL,
	[DESCS] [varchar](50) NULL,
	[REFVAL01] [varchar](500) NULL,
	[REFVAL02] [varchar](500) NULL,
	[REFVAL03] [varchar](500) NULL,
	[REFVAL04] [varchar](500) NULL,
	[REFVAL05] [varchar](500) NULL,
	[REFVAL06] [varchar](500) NULL,
	[REFVAL07] [varchar](500) NULL,
	[REFVAL08] [varchar](500) NULL,
	[REFVAL09] [varchar](500) NULL,
	[REFVAL10] [varchar](500) NULL,
	[CHAR01] [varchar](200) NULL,
	[CHAR02] [varchar](200) NULL,
	[CHAR03] [varchar](200) NULL,
	[CHAR04] [varchar](200) NULL,
	[CHAR05] [varchar](200) NULL,
	[CHAR06] [varchar](200) NULL,
	[CHAR07] [varchar](200) NULL,
	[CHAR08] [varchar](200) NULL,
	[CHAR09] [varchar](200) NULL,
	[CHAR10] [varchar](200) NULL,
	[CHAR11] [varchar](200) NULL,
	[CHAR12] [varchar](200) NULL,
	[CHAR13] [varchar](200) NULL,
	[CHAR14] [varchar](200) NULL,
	[CHAR15] [varchar](200) NULL,
	[CHAR16] [varchar](200) NULL,
	[CHAR17] [varchar](200) NULL,
	[CHAR18] [varchar](200) NULL,
	[CHAR19] [varchar](200) NULL,
	[CHAR20] [varchar](200) NULL,
	[CHAR21] [varchar](200) NULL,
	[CHAR22] [varchar](200) NULL,
	[CHAR23] [varchar](200) NULL,
	[CHAR24] [varchar](200) NULL,
	[CHAR25] [varchar](200) NULL,
	[CHAR26] [varchar](200) NULL,
	[CHAR27] [varchar](200) NULL,
	[CHAR28] [varchar](200) NULL,
	[CHAR29] [varchar](200) NULL,
	[CHAR30] [varchar](200) NULL,
	[CHAR31] [varchar](200) NULL,
	[CHAR32] [varchar](200) NULL,
	[CHAR33] [varchar](200) NULL,
	[CHAR34] [varchar](200) NULL,
	[CHAR35] [varchar](200) NULL,
	[CHAR36] [varchar](200) NULL,
	[CHAR37] [varchar](200) NULL,
	[CHAR38] [varchar](200) NULL,
	[CHAR39] [varchar](200) NULL,
	[CHAR40] [varchar](200) NULL,
	[CHAR41] [varchar](200) NULL,
	[CHAR42] [varchar](200) NULL,
	[CHAR43] [varchar](200) NULL,
	[CHAR44] [varchar](200) NULL,
	[CHAR45] [varchar](200) NULL,
	[CHAR46] [varchar](200) NULL,
	[CHAR47] [varchar](200) NULL,
	[CHAR48] [varchar](200) NULL,
	[CHAR49] [varchar](200) NULL,
	[CHAR50] [varchar](200) NULL,
	[NUM01] [numeric](19, 2) NULL,
	[NUM02] [numeric](19, 2) NULL,
	[NUM03] [numeric](19, 2) NULL,
	[NUM04] [numeric](19, 2) NULL,
	[NUM05] [numeric](19, 2) NULL,
	[NUM06] [numeric](19, 2) NULL,
	[NUM07] [numeric](19, 2) NULL,
	[NUM08] [numeric](19, 2) NULL,
	[NUM09] [numeric](19, 2) NULL,
	[NUM10] [numeric](19, 2) NULL,
	[DATE01] [datetime] NULL,
	[DATE2] [datetime] NULL,
	[DATE03] [datetime] NULL,
	[DATE04] [datetime] NULL,
	[DATE05] [datetime] NULL,
	[DATE06] [datetime] NULL,
 CONSTRAINT [D_CDSTM_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_CDSTM] UNIQUE NONCLUSTERED 
(
	[TXREFID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_CLEANLOG]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_CLEANLOG](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[TXDT] [datetime] NULL,
	[CLEANDT] [datetime] NULL,
	[DESCS] [varchar](200) NULL,
	[FROMSRC] [varchar](50) NULL,
	[TOSRC] [varchar](50) NULL,
	[TXBODY] [varchar](500) NULL,
	[STS] [varchar](10) NULL,
	[RESULT] [varchar](500) NULL,
	[RESPMSG] [varchar](max) NULL,
	[REQMSG] [varchar](max) NULL,
 CONSTRAINT [D_CLEANLOG_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_CODETYPE]    Script Date: 7/24/2025 8:31:49 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_CODETYPE](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[CODETYPE] [varchar](100) NULL,
	[CODESUBTYPE] [varchar](100) NULL,
	[CODEID] [varchar](50) NULL,
	[CODEVAL] [varchar](200) NULL,
	[CODENAME] [varchar](200) NULL,
	[CODESTS] [varchar](10) NULL,
	[ROWID] [varchar](100) NULL,
 CONSTRAINT [PK_D_CODETYPE] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_COLLECTFEEGL]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_COLLECTFEEGL](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[SERCODE] [varchar](50) NULL,
	[TXCODE] [varchar](50) NULL,
	[ACLIST] [varchar](200) NULL,
	[ROWID] [varchar](50) NULL,
 CONSTRAINT [PK_D_COLLECTFEEGL] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_ENVINFO]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_ENVINFO](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[ENV_CODE] [varchar](50) NULL,
	[ENV_VALUE] [varchar](200) NULL,
	[CHAR01] [varchar](500) NULL,
	[CHAR02] [varchar](500) NULL,
	[CHAR03] [varchar](500) NULL,
	[CHAR04] [varchar](500) NULL,
	[CHAR05] [varchar](500) NULL,
	[CHAR06] [varchar](500) NULL,
	[CHAR07] [varchar](500) NULL,
 CONSTRAINT [PK_D_ENVINFO] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_ERRORCODE]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_ERRORCODE](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[ERRCODE] [varchar](50) NULL,
	[ERRDESC] [varchar](200) NULL,
	[ERRTYPE] [varchar](50) NULL,
	[STS] [varchar](10) NULL,
	[APPLIEDON] [varchar](500) NULL,
	[APPLIEDWHEN] [varchar](200) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_ERRORCODE] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_FEEDEF]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_FEEDEF](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[FEEID] [varchar](50) NULL,
	[FEECODE] [varchar](50) NULL,
	[FEETYPE] [varchar](50) NULL,
	[FEECCY] [varchar](50) NULL,
	[FEEAMT] [numeric](19, 2) NULL,
	[MARGIN_AMT] [numeric](19, 2) NULL,
	[MIN_AMT] [numeric](19, 2) NULL,
	[MAX_AMT] [numeric](19, 2) NULL,
	[ISPERCENT] [varchar](10) NULL,
	[PERCENTVAL] [numeric](19, 2) NULL,
	[ISFEECAL] [varchar](10) NULL,
	[FEECAL] [varchar](50) NULL,
	[FEEFORMULA] [varchar](200) NULL,
	[APPLIEDON] [varchar](200) NULL,
	[APPLIEDWHEN] [varchar](200) NULL,
	[FEEAC] [varchar](50) NULL,
	[FEESTS] [varchar](10) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_FEEDEF] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_FILEINFO]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_FILEINFO](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[FILEID] [varchar](50) NULL,
	[FILENAME] [varchar](200) NULL,
	[FILESTS] [varchar](10) NULL,
	[FILEDT] [datetime] NULL,
	[USRID] [varchar](50) NULL,
	[ROWCNT] [numeric](19, 0) NULL,
	[STS] [varchar](10) NULL,
	[DESCS] [varchar](500) NULL,
	[FILETYPE] [varchar](100) NULL,
 CONSTRAINT [D_FILEINFO_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_FILEINFO] UNIQUE NONCLUSTERED 
(
	[FILEID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_FILELST]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_FILELST](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[FILEDT] [datetime] NULL,
	[FILEID] [varchar](200) NULL,
	[FILESTS] [varchar](10) NULL,
	[SETTLESTS] [varchar](10) NULL,
	[DVALUEDT] [datetime] NULL,
	[TXDT] [datetime] NULL,
	[CONSUMERNO] [varchar](200) NULL,
	[FILETYPE] [varchar](200) NULL,
	[CHAR01] [varchar](200) NULL,
	[CHAR02] [varchar](200) NULL,
	[CHAR03] [varchar](200) NULL,
	[CHAR04] [varchar](200) NULL,
	[CHAR05] [varchar](200) NULL,
	[CHAR06] [varchar](200) NULL,
	[CHAR07] [varchar](200) NULL,
	[CHAR08] [varchar](200) NULL,
	[CHAR09] [varchar](200) NULL,
	[CHAR10] [varchar](200) NULL,
	[NUM01] [numeric](19, 2) NULL,
	[NUM02] [numeric](19, 2) NULL,
	[NUM03] [numeric](19, 2) NULL,
	[NUM04] [numeric](19, 2) NULL,
	[NUM05] [numeric](19, 2) NULL,
	[NUM06] [numeric](19, 2) NULL,
	[DATE01] [datetime] NULL,
	[DATE02] [datetime] NULL,
	[DATE03] [datetime] NULL,
 CONSTRAINT [D_FILELST_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_FILELST] UNIQUE NONCLUSTERED 
(
	[CHAR01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_MERCHANTLST]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_MERCHANTLST](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[MERID] [varchar](50) NULL,
	[MERCODE] [varchar](50) NULL,
	[MERNAME] [varchar](100) NULL,
	[DESCS] [varchar](500) NULL,
	[REGIONCODE] [varchar](20) NULL,
	[MERTYPE] [varchar](50) NULL,
	[PHONEMOBILE] [varchar](50) NULL,
	[EMAIL] [varchar](100) NULL,
	[CUSCODE] [varchar](10) NULL,
	[ACNO] [varchar](500) NULL,
	[FEECODE] [varchar](50) NULL,
	[SERCODE] [varchar](50) NULL,
	[CCYID] [varchar](3) NULL,
	[COMCODE] [varchar](50) NULL,
	[ISFEEAPPLY] [varchar](1) NULL,
	[ISGLDEF] [varchar](1) NULL,
	[COUNTRY] [varchar](10) NULL,
	[STATUS] [varchar](1) NULL,
	[ID] [varchar](50) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_MERCHANTLST] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_MERCHANTLST] UNIQUE NONCLUSTERED 
(
	[MERCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_OTPINFO]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_OTPINFO](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[TXREFID] [varchar](50) NULL,
	[TXDT] [datetime] NULL,
	[COMCODE] [varchar](50) NULL,
	[XREF] [varchar](100) NULL,
	[OTPCODE] [varchar](10) NULL,
	[OTPSTS] [varchar](1) NULL,
	[REQBODY] [varchar](500) NULL,
	[CREATEDT] [datetime] NULL,
	[EXPIREDT] [datetime] NULL,
 CONSTRAINT [D_OTPINFO_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_OTPINFO] UNIQUE NONCLUSTERED 
(
	[TXREFID] ASC,
	[OTPCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_SCHEDULECONFIGURATION]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_SCHEDULECONFIGURATION](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[SCHEDULEID] [varchar](50) NULL,
	[SCHDULECODE] [varchar](50) NULL,
	[SCHEDULENAME] [varchar](200) NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[STEPCODE] [varchar](50) NULL,
	[STEPORD] [varchar](50) NULL,
	[SCHBODY] [varchar](max) NULL,
	[SCHEDULEVER] [varchar](50) NULL,
	[FREQUENCY] [varchar](50) NULL,
	[INTERVAL] [varchar](50) NULL,
	[INTERVALTYPE] [varchar](50) NULL,
	[SCHTYPE] [varchar](100) NULL,
	[SCHPARA] [varchar](100) NULL,
	[STATUS] [varchar](10) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_SCHEDULECONFIGURATION] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_SERVICECODE]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_SERVICECODE](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[SERCODE] [varchar](50) NULL,
	[SERVICEID] [varchar](50) NULL,
	[NAME] [varchar](200) NULL,
	[DESCRIPTION] [varchar](500) NULL,
	[STATUS] [varchar](10) NULL,
	[CREATEDT] [datetime] NULL,
	[ROWID] [varchar](50) NULL,
 CONSTRAINT [PK_D_SERVICECODE] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_SERVICECODE] UNIQUE NONCLUSTERED 
(
	[SERCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_SERVICEREGISTRATION]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_SERVICEREGISTRATION](
	[SHORTNAME] [varchar](50) NOT NULL,
	[FULLNAME] [varchar](200) NULL,
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[SERVICEID] [varchar](50) NULL,
	[SERCODE] [varchar](50) NULL,
	[NAME] [varchar](500) NULL,
	[TXCODE] [varchar](50) NULL,
	[TRANCODE] [varchar](50) NULL,
	[BCODE] [varchar](50) NULL,
	[TXCHANNEL] [varchar](50) NULL,
	[STATUS] [varchar](10) NULL,
	[ISDIRECTDEBIT] [varchar](10) NULL,
	[ISCOUNTER] [varchar](10) NULL,
	[ISINTERBANK] [varchar](10) NULL,
	[ISFEEAPPLY] [varchar](10) NULL,
	[GLACNO] [varchar](50) NULL,
	[FEECODE] [varchar](50) NULL,
	[CCYID] [varchar](50) NULL,
	[ISGLPOSTING] [varchar](10) NULL,
	[ISCOLLECTFEE] [varchar](10) NULL,
	[CUSCODE] [varchar](50) NULL,
	[CUSMOBILE] [varchar](50) NULL,
	[EMAIL] [varchar](100) NULL,
	[NOTIFYMAIL] [varchar](100) NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[ID] [varchar](50) NULL,
	[CATID] [varchar](50) NULL,
	[ISOTP] [varchar](10) NULL,
	[ISSMS] [varchar](10) NULL,
	[ISMAIL] [varchar](10) NULL,
	[INSTALLDT] [datetime] NULL,
	[LAUNCHDT] [datetime] NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_SERVICEREGISTRATION] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_SERVICEREGISTRATION] UNIQUE NONCLUSTERED 
(
	[SHORTNAME] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_SWIFTCODE]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_SWIFTCODE](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[BANKCODE] [varchar](50) NULL,
	[SWIFTCODE] [varchar](50) NULL,
	[CODESTS] [varchar](10) NULL,
	[ROWID] [varchar](50) NULL,
 CONSTRAINT [PK_D_SWIFTCODE] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_SWIFTCODE] UNIQUE NONCLUSTERED 
(
	[SWIFTCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_TMNLST]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_TMNLST](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[TMNID] [varchar](50) NULL,
	[TMNCODE] [varchar](50) NULL,
	[TMNTYPE] [varchar](50) NULL,
	[TMNNAME] [varchar](200) NULL,
	[ADDR] [varchar](200) NULL,
	[LOCATION] [varchar](500) NULL,
	[BANKID] [varchar](50) NULL,
	[ISPUBAREA] [varchar](10) NULL,
	[ISBRNAREA] [varchar](10) NULL,
	[ISONUS] [varchar](10) NULL,
	[ISOFFUS] [varchar](10) NULL,
	[STATUS] [varchar](10) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
	[ISCSHDPT] [varchar](1) NULL,
	[MERCODE] [varchar](50) NULL,
 CONSTRAINT [PK_D_TMNLST] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_TXDEF]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_TXDEF](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[TXFIELD] [varchar](200) NULL,
	[FIELDVAL] [varchar](200) NULL,
	[FIELDLEN] [varchar](100) NULL,
	[FIELDTYPE] [varchar](50) NULL,
	[ISFIELDNULL] [varchar](10) NULL,
	[FIELDSTS] [varchar](10) NULL,
	[ROWID] [varchar](50) NULL,
 CONSTRAINT [PK_D_TXDEF] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_WFSTM]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_WFSTM](
	[RECID] [bigint] IDENTITY(1,1) NOT NULL,
	[TXREFID] [varchar](50) NULL,
	[TXDT] [datetime] NULL,
	[TXCODE] [varchar](50) NULL,
	[WFCODE] [varchar](50) NULL,
	[WFBODY] [varchar](max) NULL,
	[WFSTS] [varchar](10) NULL,
	[REQUESTMSG] [varchar](max) NULL,
	[RESPONSEMSG] [varchar](max) NULL,
	[WFEXDT] [datetime] NULL,
	[ID] [varchar](50) NULL,
 CONSTRAINT [D_WFSTM_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_D_WFSTM] UNIQUE NONCLUSTERED 
(
	[TXREFID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[D_WORKFLOW]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[D_WORKFLOW](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[WFID] [varchar](200) NULL,
	[WFCODE] [varchar](200) NULL,
	[WFSTS] [varchar](10) NULL,
	[WFTYPE] [varchar](50) NULL,
	[WFDESC] [varchar](500) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_D_WORKFLOW] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_APISTM]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_APISTM](
	[RECID] [bigint] IDENTITY(1,1) NOT NULL,
	[TXDT] [datetime] NULL,
	[TXREFID] [varchar](50) NULL,
	[TRACE] [varchar](50) NULL,
	[TXTIME] [varchar](20) NULL,
	[STATUS] [varchar](10) NULL,
	[MID] [varchar](50) NULL,
	[TXCODE] [varchar](50) NULL,
	[TRANCODE] [varchar](50) NULL,
	[BCODE] [varchar](50) NULL,
	[PAYCODE] [varchar](50) NULL,
	[DVALUEDT] [datetime] NULL,
	[TXUPDATEDT] [datetime] NULL,
	[COMCODE] [varchar](50) NULL,
	[ISONUS] [varchar](10) NULL,
	[ISOFFUS] [varchar](10) NULL,
	[PCODE] [varchar](50) NULL,
	[RRN] [varchar](50) NULL,
	[CARDBIN] [varchar](50) NULL,
	[CHAR01] [varchar](200) NULL,
	[CHAR02] [varchar](200) NULL,
	[CHAR03] [varchar](200) NULL,
	[CHAR04] [varchar](200) NULL,
	[CHAR05] [varchar](200) NULL,
	[CHAR06] [varchar](200) NULL,
	[CHAR07] [varchar](200) NULL,
	[CHAR08] [varchar](200) NULL,
	[CHAR09] [varchar](200) NULL,
	[CHAR10] [varchar](200) NULL,
	[CHAR11] [varchar](200) NULL,
	[CHAR12] [varchar](200) NULL,
	[CHAR13] [varchar](200) NULL,
	[CHAR14] [varchar](200) NULL,
	[CHAR15] [varchar](200) NULL,
	[CHAR16] [varchar](200) NULL,
	[CHAR17] [varchar](200) NULL,
	[CHAR18] [varchar](200) NULL,
	[CHAR19] [varchar](200) NULL,
	[CHAR20] [varchar](200) NULL,
	[NUM01] [numeric](19, 2) NULL,
	[NUM02] [numeric](19, 2) NULL,
	[NUM03] [numeric](19, 2) NULL,
	[NUM04] [numeric](19, 2) NULL,
	[NUM05] [numeric](19, 2) NULL,
	[NUM06] [numeric](19, 2) NULL,
	[NUM07] [numeric](19, 2) NULL,
	[NUM08] [numeric](19, 2) NULL,
	[NUM09] [numeric](19, 2) NULL,
	[NUM10] [numeric](19, 2) NULL,
	[DATE01] [datetime] NULL,
	[DATE2] [datetime] NULL,
	[DATE03] [datetime] NULL,
	[DATE04] [datetime] NULL,
	[DATE05] [datetime] NULL,
	[DATE06] [datetime] NULL,
	[ID] [varchar](50) NULL,
	[TRNDT] [datetime2](7) NULL,
 CONSTRAINT [R_APISTM_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_R_APISTM] UNIQUE NONCLUSTERED 
(
	[TXREFID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_CDSTM]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_CDSTM](
	[RECID] [bigint] IDENTITY(1,1) NOT NULL,
	[TXDT] [datetime] NULL,
	[TXREFID] [varchar](50) NULL,
	[TRACE] [varchar](50) NULL,
	[TXTIME] [varchar](50) NULL,
	[MID] [varchar](50) NULL,
	[TNO] [varchar](50) NULL,
	[XREF] [varchar](50) NULL,
	[USRID] [varchar](50) NULL,
	[USRAPPR] [varchar](50) NULL,
	[TMNID] [varchar](50) NULL,
	[TMNCODE] [varchar](50) NULL,
	[TMNTYPE] [varchar](50) NULL,
	[TXCODE] [varchar](50) NULL,
	[TRANCODE] [varchar](50) NULL,
	[BCODE] [varchar](50) NULL,
	[PAYCODE] [varchar](50) NULL,
	[PAYREFNO] [varchar](50) NULL,
	[DVALUEDT] [datetime] NULL,
	[TXUPDATEDT] [datetime] NULL,
	[BANKID] [varchar](50) NULL,
	[BRANCHCODE] [varchar](50) NULL,
	[SWIFTCODE] [varchar](50) NULL,
	[ID] [varchar](50) NULL,
	[CARDNO] [varchar](50) NULL,
	[CARDTYPE] [varchar](50) NULL,
	[CUSCODE] [varchar](50) NULL,
	[CUSACCR] [varchar](50) NULL,
	[CUSMOBILE] [varchar](50) NULL,
	[MERCHANTID] [varchar](50) NULL,
	[NOTIFYMAIL] [varchar](100) NULL,
	[INCACNO] [varchar](500) NULL,
	[AMT] [numeric](19, 2) NULL,
	[CCYCODE] [varchar](50) NULL,
	[REGION] [varchar](50) NULL,
	[FEECODE] [varchar](200) NULL,
	[FEEVAL01] [numeric](19, 2) NULL,
	[FEEVAL02] [numeric](19, 2) NULL,
	[COMCODE] [varchar](50) NULL,
	[ISONUS] [varchar](10) NULL,
	[ISOFFUS] [varchar](10) NULL,
	[PCODE] [varchar](50) NULL,
	[RRN] [varchar](50) NULL,
	[CARDBIN] [varchar](50) NULL,
	[TRANTYPE] [varchar](50) NULL,
	[ISOFFLINE] [varchar](10) NULL,
	[ISONLINE] [varchar](10) NULL,
	[RSTS] [varchar](10) NULL,
	[WFSTS] [varchar](10) NULL,
	[TXSTS] [varchar](10) NULL,
	[STS] [varchar](10) NULL,
	[WFCODE] [varchar](50) NULL,
	[ERRCODE] [varchar](50) NULL,
	[DESCS] [varchar](50) NULL,
	[REFVAL01] [varchar](500) NULL,
	[REFVAL02] [varchar](500) NULL,
	[REFVAL03] [varchar](500) NULL,
	[REFVAL04] [varchar](500) NULL,
	[REFVAL05] [varchar](500) NULL,
	[REFVAL06] [varchar](500) NULL,
	[REFVAL07] [varchar](500) NULL,
	[REFVAL08] [varchar](500) NULL,
	[REFVAL09] [varchar](500) NULL,
	[REFVAL10] [varchar](500) NULL,
	[CHAR01] [varchar](200) NULL,
	[CHAR02] [varchar](200) NULL,
	[CHAR03] [varchar](200) NULL,
	[CHAR04] [varchar](200) NULL,
	[CHAR05] [varchar](200) NULL,
	[CHAR06] [varchar](200) NULL,
	[CHAR07] [varchar](200) NULL,
	[CHAR08] [varchar](200) NULL,
	[CHAR09] [varchar](200) NULL,
	[CHAR10] [varchar](200) NULL,
	[CHAR11] [varchar](200) NULL,
	[CHAR12] [varchar](200) NULL,
	[CHAR13] [varchar](200) NULL,
	[CHAR14] [varchar](200) NULL,
	[CHAR15] [varchar](200) NULL,
	[CHAR16] [varchar](200) NULL,
	[CHAR17] [varchar](200) NULL,
	[CHAR18] [varchar](200) NULL,
	[CHAR19] [varchar](200) NULL,
	[CHAR20] [varchar](200) NULL,
	[CHAR21] [varchar](200) NULL,
	[CHAR22] [varchar](200) NULL,
	[CHAR23] [varchar](200) NULL,
	[CHAR24] [varchar](200) NULL,
	[CHAR25] [varchar](200) NULL,
	[CHAR26] [varchar](200) NULL,
	[CHAR27] [varchar](200) NULL,
	[CHAR28] [varchar](200) NULL,
	[CHAR29] [varchar](200) NULL,
	[CHAR30] [varchar](200) NULL,
	[CHAR31] [varchar](200) NULL,
	[CHAR32] [varchar](200) NULL,
	[CHAR33] [varchar](200) NULL,
	[CHAR34] [varchar](200) NULL,
	[CHAR35] [varchar](200) NULL,
	[CHAR36] [varchar](200) NULL,
	[CHAR37] [varchar](200) NULL,
	[CHAR38] [varchar](200) NULL,
	[CHAR39] [varchar](200) NULL,
	[CHAR40] [varchar](200) NULL,
	[CHAR41] [varchar](200) NULL,
	[CHAR42] [varchar](200) NULL,
	[CHAR43] [varchar](200) NULL,
	[CHAR44] [varchar](200) NULL,
	[CHAR45] [varchar](200) NULL,
	[CHAR46] [varchar](200) NULL,
	[CHAR47] [varchar](200) NULL,
	[CHAR48] [varchar](200) NULL,
	[CHAR49] [varchar](200) NULL,
	[CHAR50] [varchar](200) NULL,
	[NUM01] [numeric](19, 2) NULL,
	[NUM02] [numeric](19, 2) NULL,
	[NUM03] [numeric](19, 2) NULL,
	[NUM04] [numeric](19, 2) NULL,
	[NUM05] [numeric](19, 2) NULL,
	[NUM06] [numeric](19, 2) NULL,
	[NUM07] [numeric](19, 2) NULL,
	[NUM08] [numeric](19, 2) NULL,
	[NUM09] [numeric](19, 2) NULL,
	[NUM10] [numeric](19, 2) NULL,
	[DATE01] [datetime] NULL,
	[DATE2] [datetime] NULL,
	[DATE03] [datetime] NULL,
	[DATE04] [datetime] NULL,
	[DATE05] [datetime] NULL,
	[DATE06] [datetime] NULL,
 CONSTRAINT [R_CDSTM_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_R_CDSTM] UNIQUE NONCLUSTERED 
(
	[TXREFID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[R_WFSTM]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[R_WFSTM](
	[RECID] [bigint] IDENTITY(1,1) NOT NULL,
	[TXREFID] [varchar](50) NULL,
	[TXDT] [datetime] NULL,
	[TXCODE] [varchar](50) NULL,
	[WFCODE] [varchar](50) NULL,
	[WFBODY] [varchar](max) NULL,
	[WFSTS] [varchar](10) NULL,
	[REQUESTMSG] [varchar](max) NULL,
	[RESPONSEMSG] [varchar](max) NULL,
	[WFEXDT] [datetime] NULL,
	[ID] [varchar](50) NULL,
 CONSTRAINT [R_WFSTM_PKEY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY],
 CONSTRAINT [UC_R_WFSTM] UNIQUE NONCLUSTERED 
(
	[TXREFID] ASC,
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSCONFIGURATION]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSCONFIGURATION](
	[FULL_PATH] [varchar](200) NULL,
	[APP] [varchar](50) NULL,
	[DOMAIN] [varchar](50) NULL,
	[XREF] [varchar](50) NULL,
	[TYPE] [varchar](50) NULL,
	[SUB_TYPE] [varchar](50) NULL,
	[CONTENT] [varchar](max) NULL,
	[FILE_NAME] [varchar](200) NULL,
	[FOLDER_NAME] [varchar](200) NULL,
	[FOLDER_PATH] [varchar](200) NULL,
	[LAST_MODIFIED] [datetime] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSLOG]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSLOG](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[LOGREF] [varchar](50) NULL,
	[ACTION_TYPE] [varchar](50) NULL,
	[ACTION_USR_ID] [varchar](50) NULL,
	[TARGET_USER_ID] [varchar](50) NULL,
	[DESCS] [varchar](max) NULL,
	[LOGSTS] [varchar](10) NULL,
	[LOGDT] [datetime] NULL,
 CONSTRAINT [PK_SYSLOG] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSPORTAL]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSPORTAL](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[PORTALID] [varchar](50) NULL,
	[PORTALCODE] [varchar](50) NULL,
	[NAME] [varchar](200) NULL,
	[DESCRIPTION] [varchar](200) NULL,
	[ROUTE_URL] [varchar](200) NULL,
	[IS_WORKFLOW] [varchar](10) NULL,
	[PORTNO] [varchar](50) NULL,
	[SERVICETYPE] [varchar](50) NULL,
	[MWID] [varchar](50) NULL,
	[INSTALLDT] [datetime] NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_SYSPORTAL] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSPORTALTOKEN]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSPORTALTOKEN](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[MWID] [varchar](50) NULL,
	[APP] [varchar](50) NULL,
	[DOMAIN] [varchar](50) NULL,
	[PORTALCODE] [varchar](50) NULL,
	[TOKEN] [varchar](max) NULL,
	[TOKENDT] [datetime] NULL,
	[EXPIREDT] [datetime2](7) NULL,
	[TOKENSTS] [varchar](10) NULL,
 CONSTRAINT [PK_SYSPORTALTOKEN] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSPWDHISTORY]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSPWDHISTORY](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[USERID] [varchar](50) NULL,
	[USRPWD] [varchar](200) NULL,
	[PWDSTR01] [varbinary](500) NULL,
	[PWDSTR02] [varbinary](500) NULL,
	[PWDSTR03] [varbinary](500) NULL,
	[PWDSTR04] [varbinary](500) NULL,
	[PWDSTR05] [varbinary](500) NULL,
	[LASTLOGIN] [datetime] NULL,
	[LASTMODIFIED] [datetime] NULL,
 CONSTRAINT [PK_SYSPWDHISTORY] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSUSER]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSUSER](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[USERID] [varchar](50) NULL,
	[FULLNAME] [varchar](200) NULL,
	[EMAIL] [varchar](100) NULL,
	[BANKID] [varchar](50) NULL,
	[BRANCHCODE] [varchar](50) NULL,
	[USRTYPE] [varchar](50) NULL,
	[ISUSRROLE] [varchar](10) NULL,
	[ISUSRTOKEN] [varchar](10) NULL,
	[USRTOKEN] [varchar](500) NULL,
	[ISACTIVE] [varchar](10) NULL,
	[ISBLOCK] [varchar](10) NULL,
	[ISVERIFY] [varchar](10) NULL,
	[ISUSRPWD] [varchar](10) NULL,
	[APP] [varchar](50) NULL,
	[DOMAIN] [varchar](50) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_SYSUSER] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSUSERCONFIG]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSUSERCONFIG](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[APP] [varchar](50) NULL,
	[DOMAIN] [varchar](50) NULL,
	[USERID] [varchar](50) NULL,
	[MID] [varchar](50) NULL,
	[USRTOKEN] [varchar](500) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_SYSUSERCONFIG] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSUSERPIN]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSUSERPIN](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[USERID] [varchar](50) NULL,
	[USRPIN] [varchar](200) NULL,
	[SALTPIN] [varchar](200) NULL,
	[HASHPIN] [varbinary](500) NULL,
	[HASHKEY] [varchar](200) NULL,
	[HASHCERT] [varchar](200) NULL,
	[PINSTS] [varchar](10) NULL,
	[LASTMODIFIED] [datetime] NULL,
 CONSTRAINT [PK_SYSUSERPIN] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSUSERPORTAL]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSUSERPORTAL](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[PORTALID] [varchar](50) NULL,
	[USERCODE] [varchar](50) NULL,
	[USERTOKEN] [varchar](max) NULL,
	[EXPIREDT] [datetime2](7) NULL,
	[TOKENDT] [datetime] NULL,
	[STS] [varchar](10) NULL,
 CONSTRAINT [PK_SYSUSERPORTAL] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSUSERPROFILE]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSUSERPROFILE](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[APP] [varchar](50) NULL,
	[DOMAIN] [varchar](50) NULL,
	[MID] [varchar](50) NULL,
	[USERID] [varchar](50) NULL,
	[EMAIL] [varchar](100) NULL,
	[PHONE_NUMBER] [varchar](50) NULL,
	[PARABODY] [varchar](500) NULL,
 CONSTRAINT [PK_SYSUSERPROFILE] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSUSERPWD]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSUSERPWD](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[USERID] [varchar](50) NULL,
	[USRPWD] [varchar](200) NULL,
	[SALTPWD] [varchar](200) NULL,
	[HASHPWD] [varbinary](500) NULL,
	[HASHKEY] [varchar](200) NULL,
	[HASHCERT] [varchar](200) NULL,
	[PWDSTS] [varchar](10) NULL,
	[LASTMODIFIED] [datetime] NULL,
 CONSTRAINT [PK_SYSUSERPWD] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SYSUSERROLE]    Script Date: 7/24/2025 8:31:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SYSUSERROLE](
	[RECID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[ROLEID] [varchar](50) NULL,
	[ROLECODE] [varchar](50) NULL,
	[ROLEDESC] [varchar](200) NULL,
	[ROLESTS] [varchar](10) NULL,
	[MAKER] [varchar](50) NULL,
	[APPROVER] [varchar](50) NULL,
	[CREATEDT] [datetime] NULL,
 CONSTRAINT [PK_SYSUSERROLE] PRIMARY KEY CLUSTERED 
(
	[RECID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_branchcode_branchcode]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_branchcode_branchcode] ON [dbo].[D_BRANCHCODE]
(
	[BRANCHCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cardlst_cardsts]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cardlst_cardsts] ON [dbo].[D_CARDLST]
(
	[CARDSTS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cardlst_cardtype]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cardlst_cardtype] ON [dbo].[D_CARDLST]
(
	[CARDTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cardlst_hashpin]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cardlst_hashpin] ON [dbo].[D_CARDLST]
(
	[HASHPIN] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cardlst_isverify]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cardlst_isverify] ON [dbo].[D_CARDLST]
(
	[ISVERIFY] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_cardtype]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_cardtype] ON [dbo].[D_CDSTM]
(
	[CARDTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_char10]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_char10] ON [dbo].[D_CDSTM]
(
	[CHAR10] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_char20]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_char20] ON [dbo].[D_CDSTM]
(
	[CHAR20] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_char30]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_char30] ON [dbo].[D_CDSTM]
(
	[CHAR30] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [d_cdstm_dvaluedt]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_dvaluedt] ON [dbo].[D_CDSTM]
(
	[DVALUEDT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
/****** Object:  Index [d_cdstm_num01]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_num01] ON [dbo].[D_CDSTM]
(
	[NUM01] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_refval04]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_refval04] ON [dbo].[D_CDSTM]
(
	[REFVAL04] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_sts]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_sts] ON [dbo].[D_CDSTM]
(
	[STS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_trace]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_trace] ON [dbo].[D_CDSTM]
(
	[TRACE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_txcode]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_txcode] ON [dbo].[D_CDSTM]
(
	[TXCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_cdstm_txsts]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_cdstm_txsts] ON [dbo].[D_CDSTM]
(
	[TXSTS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_codetype_codesubtype]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_codetype_codesubtype] ON [dbo].[D_CODETYPE]
(
	[CODESUBTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_codetype_codetype]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_codetype_codetype] ON [dbo].[D_CODETYPE]
(
	[CODETYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_errorcode_errcode]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_errorcode_errcode] ON [dbo].[D_ERRORCODE]
(
	[ERRCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_tmnlst_iscshdpt]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_tmnlst_iscshdpt] ON [dbo].[D_TMNLST]
(
	[ISCSHDPT] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_tmnlst_isoffus]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_tmnlst_isoffus] ON [dbo].[D_TMNLST]
(
	[ISOFFUS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_tmnlst_isonus]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_tmnlst_isonus] ON [dbo].[D_TMNLST]
(
	[ISONUS] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_tmnlst_tmntype]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_tmnlst_tmntype] ON [dbo].[D_TMNLST]
(
	[TMNTYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [d_wfstm_txcode]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [d_wfstm_txcode] ON [dbo].[D_WFSTM]
(
	[TXCODE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [syslog_action_type]    Script Date: 7/24/2025 8:31:50 PM ******/
CREATE NONCLUSTERED INDEX [syslog_action_type] ON [dbo].[SYSLOG]
(
	[ACTION_TYPE] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[D_APISTM] ADD  CONSTRAINT [DF_APISTM_TXDT]  DEFAULT (getdate()) FOR [TXDT]
GO
ALTER TABLE [dbo].[D_APISTM] ADD  CONSTRAINT [DF_APISTM_ID]  DEFAULT (replace(lower(newid()),'-','')) FOR [ID]
GO
ALTER TABLE [dbo].[D_CDSTM] ADD  CONSTRAINT [DF_CDSTM_TXDT]  DEFAULT (getdate()) FOR [TXDT]
GO
ALTER TABLE [dbo].[D_CDSTM] ADD  CONSTRAINT [DF_CDSTM_DVALUEDT]  DEFAULT (CONVERT([date],getdate())) FOR [DVALUEDT]
GO
ALTER TABLE [dbo].[D_CDSTM] ADD  CONSTRAINT [DF_CDSTM_TXUPDATEDT]  DEFAULT (getutcdate()) FOR [TXUPDATEDT]
GO
ALTER TABLE [dbo].[D_CDSTM] ADD  CONSTRAINT [DF_CDSTM_ID]  DEFAULT (replace(lower(newid()),'-','')) FOR [ID]
GO
ALTER TABLE [dbo].[D_FILELST] ADD  CONSTRAINT [DF_FILELST_FILEDT]  DEFAULT (getdate()) FOR [FILEDT]
GO
ALTER TABLE [dbo].[D_OTPINFO] ADD  CONSTRAINT [DF_OTPINFO_TXDT]  DEFAULT (getdate()) FOR [TXDT]
GO
ALTER TABLE [dbo].[D_OTPINFO] ADD  CONSTRAINT [DF_OTPINFO_EXPIREDT]  DEFAULT (dateadd(minute,(3),getdate())) FOR [EXPIREDT]
GO
ALTER TABLE [dbo].[D_WFSTM] ADD  CONSTRAINT [DF_WFSTM_TXDT]  DEFAULT (getdate()) FOR [TXDT]
GO
ALTER TABLE [dbo].[D_WFSTM] ADD  CONSTRAINT [DF_WFSTM_ID]  DEFAULT (replace(lower(newid()),'-','')) FOR [ID]
GO
USE [master]
GO
ALTER DATABASE [KCARD] SET  READ_WRITE 
GO
