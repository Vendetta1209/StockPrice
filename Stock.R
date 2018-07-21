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

#カ�?ゴリごとに追�?
insertSqlData <- function(ticker_id){
  tmp <- getStock(ticker_id) %>% toDataFrame()
  for (i in 1:nrow(tmp)){
    sqlQuery(db, str_c("INSERT INTO dbo.StockPrice VALUES ('",ticker_id,"','",tmp[i,1],"','",tmp[i,2],"','",tmp[i,3],"','",tmp[i,4],"','",tmp[i,5],"','",tmp[i,6],"','",tmp[i,7],"')"))
  }
}