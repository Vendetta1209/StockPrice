SELECT dbo.Company.TickerID,dbo.Company.CompanyName,dbo.Company.Unit,dbo.CloseTable.date,dbo.CloseTable.OpenPrice,dbo.Company.Categoly
FROM [dbo].[Company]
 LEFT OUTER JOIN  [dbo].[CloseTable]
 on [dbo].Company.TickerID = [dbo].CloseTable.TickerID
WHERE Unit = 100