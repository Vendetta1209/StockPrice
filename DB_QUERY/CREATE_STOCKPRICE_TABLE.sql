USE [STOCK]
GO

/****** Object:  Table [dbo].[StockPrice]    Script Date: 2018/07/22 2:42:41 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[StockPrice](
	[TickerCode] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[OpenPrice] [int] NULL,
	[HighPrice] [int] NULL,
	[LowPrice] [int] NULL,
	[ClosePrice] [int] NULL,
	[Volume] [int] NULL,
	[AdjustedPrice] [int] NULL,
 CONSTRAINT [PK_StockPrice] PRIMARY KEY CLUSTERED 
(
	[TickerCode] ASC,
	[Date] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO


