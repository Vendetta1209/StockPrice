USE [STOCK]
GO

/****** Object:  Table [dbo].[Company]    Script Date: 2018/07/20 22:48:54 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[Company](
	[TickerCode] [int] NOT NULL,
	[CompanyName] [nvarchar](100) NULL,
	[Market] [nvarchar](50) NULL,
	[Categoly] [nvarchar](50) NULL,
	[Unit] [nvarchar](24) NULL,
	[isNikkei225] [nchar](5) NULL,
 CONSTRAINT [PK_Company] PRIMARY KEY CLUSTERED 
(
	[TickerCode] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


