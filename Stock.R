library(RODBC)
library(XML)
library(quantmod)
library(stringr)
library(dplyr)

#ODBC
db <- odbcConnect("rtest", uid="test", pwd="test")
query <- sqlQuery(db , "select * from dbo.Company")

getStock <- function(ticker_id, from_date = 180){
  getSymbols(as.character(ticker_id),
             src="yahooj",
             auto.assign=FALSE,
             from = Sys.Date() - from_date) %>% return()
}

toDataFrame <- function(x){
  data.frame(date=index(x), coredata(x)) %>% return()
}

#カテゴリごとに追加
insertSqlData <- function(ticker_id, stock_type){
  tmp <- getStock(ticker_id) %>% toDataFrame()
  for (i in 1:nrow(tmp)){
    switch(stock_type,
           #Open
           "1" = sqlQuery(db, str_c("INSERT INTO dbo.OpenPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,2],"')")),
           #High
           "2" = sqlQuery(db, str_c("INSERT INTO dbo.HighPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,3],"')")),
           #Low
           "3" = sqlQuery(db, str_c("INSERT INTO dbo.LowPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,4],"')")),
           #Close
           "4" = sqlQuery(db, str_c("INSERT INTO dbo.ClosePrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,5],"')")),
           #Volume
           "5" = sqlQuery(db, str_c("INSERT INTO dbo.Volume VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,6],"')")),
           #Adjusted
           "6" = sqlQuery(db, str_c("INSERT INTO dbo.AdjustedPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,7],"')"))
    )
  }
}

#カテゴリすべて追加
insertSqlDataAll <- function(ticker_id){
  tmp <- getStock(ticker_id) %>% toDataFrame()
  for (i in 1:nrow(tmp)){
    #Open
    sqlQuery(db, str_c("INSERT INTO dbo.OpenPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,2],"')"))
    #High
    sqlQuery(db, str_c("INSERT INTO dbo.HighPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,3],"')"))
    #Low
    sqlQuery(db, str_c("INSERT INTO dbo.LowPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,4],"')"))
    #Close
    sqlQuery(db, str_c("INSERT INTO dbo.ClosePrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,5],"')"))
    #Volume
    sqlQuery(db, str_c("INSERT INTO dbo.Volume VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,6],"')"))
    #Adjusted
    sqlQuery(db, str_c("INSERT INTO dbo.AdjustedPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,7],"')"))
    
  }
}
  