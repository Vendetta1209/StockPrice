library(RODBC)
library(XML)
library(quantmod)

#ODBC
db <- odbcConnect("rtest", uid="test", pwd="test")
query <- sqlQuery(db , "select * from dbo.Company")

getStock <- function(x){
  getSymbols(as.character(x),
             src="yahooj",
             auto.assign=FALSE,
             from = Sys.Date() - 180) %>% return()
}

toDataFrame <- function(x){
  data.frame(date=index(x), coredata(x)) %>% return()
}

#ƒJƒeƒSƒŠ‚²‚Æ‚É’Ç‰Á
insertSqlData <- function(ticker_id, stock_type){
  tmp <- getStock(ticker_id) %>% toDataFrame()
  for (i in 1:nrow(tmp)){
    switch(stock_type,
           #Open
           "1" = sqlQuery(db, str_c("INSERT INTO dbo.OpenTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,2],"')")),
           #High
           "2" = sqlQuery(db, str_c("INSERT INTO dbo.HighTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,3],"')")),
           #Low
           "3" = sqlQuery(db, str_c("INSERT INTO dbo.LowTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,4],"')")),
           #Close
           "4" = sqlQuery(db, str_c("INSERT INTO dbo.CloseTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,5],"')")),
           #Volume
           "5" = sqlQuery(db, str_c("INSERT INTO dbo.VolumeTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,6],"')")),
           #Adjusted
           "6" = sqlQuery(db, str_c("INSERT INTO dbo.AdjustedTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,7],"')"))
    )
  }
}

#ƒJƒeƒSƒŠ‚·‚×‚Ä’Ç‰Á
insertSqlDataAll <- function(ticker_id){
  tmp <- getStock(ticker_id) %>% toDataFrame()
  for (i in 1:nrow(tmp)){
    #Open
    sqlQuery(db, str_c("INSERT INTO dbo.OpenTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,2],"')"))
    #High
    sqlQuery(db, str_c("INSERT INTO dbo.HighTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,3],"')"))
    #Low
    sqlQuery(db, str_c("INSERT INTO dbo.LowTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,4],"')"))
    #Close
    sqlQuery(db, str_c("INSERT INTO dbo.CloseTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,5],"')"))
    #Volume
    sqlQuery(db, str_c("INSERT INTO dbo.VolumeTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,6],"')"))
    #Adjusted
    sqlQuery(db, str_c("INSERT INTO dbo.AdjustedTable VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,7],"')"))
    
  }
}
  