library(RSelenium)

remDr <- remoteDriver(port = 4445L)

remDr$open()

## url <- "http://www.flashscore.com/match/Cj6I5iL9/#match-statistics;0"
url <- "https://www.whoscored.com/Regions/31/Tournaments/95/Seasons/8555/Stages/19551/PlayerStatistics/Brazil-Brasileir%C3%A3o-2021"

xp <- '//*[@id="top-player-stats-summary-grid"]'

remDr$navigate(url)

webElem <- remDr$findElements(using = 'xpath', xp)

webElem <- unlist(lapply(webElem, function(x){x$getElementText()}))

remDr$close()
