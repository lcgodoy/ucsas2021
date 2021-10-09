library(RSelenium)

url <- "https://www.flashscore.com/team/connecticut-huskies/8rqVf3Tj/results/"

remDr <- remoteDriver(port = 4445L)

remDr$open(silent = TRUE)

remDr$navigate(url)

repeat{
  b <- tryCatch({
    suppressMessages({
      webElemMore <- remDr$findElement(using = 'xpath', 
                        '//*[@id="live-table"]/div[1]/div/div/a')
      webElemMore$clickElement()
    })
  }, error = function(e) e)
  if(inherits(b, "error")) break
}

webElemTime <- remDr$findElements(using = 'xpath', 
                              '//*[@class="event__time"]')
webElemTime <- 
  unlist(lapply(webElemTime, function(x){x$getElementText()}))
webElemTime <- gsub("\\n", " ", webElemTime)

webElemHome <- 
  remDr$findElements(using = 'class name', 
                     'event__participant')
webElemHome <- 
  unlist(lapply(webElemHome, function(x){x$getElementText()}))
webElemScore <- 
  remDr$findElements(using = 'class', 'event__score')
webElemScore <- 
  unlist(lapply(webElemScore, function(x){x$getElementText()}))
webElemResult <- 
  remDr$findElements(using = 'class', 'wld')
webElemResult <- 
    unlist(lapply(webElemResult, function(x){x$getElementText()}))

n <- length(webElemHome)
basketball <- 
  data.frame(time = webElemTime,
             Home = webElemHome[seq(n) %% 2 == 1],
             Away = webElemHome[seq(n) %% 2 == 0],
             HomeS = webElemScore[seq(n) %% 2 == 1],
             AwayS = webElemScore[seq(n) %% 2 == 0],
             Result = webElemResult)
head(basketball)
remDr$close()
