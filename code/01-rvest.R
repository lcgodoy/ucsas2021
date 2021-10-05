library(rvest)
library(dplyr)
library(ggplot2)

url_elo <- "https://www.sports-reference.com/cbb/schools/"

raw_webpage <- readLines(url_elo)

webpage <- read_html(url_elo)

txt <-
    webpage |>
    html_elements("p") |>
    html_text2()

elo_class <- webpage %>%
    html_elements("table") %>%
    html_table() 


elo_id <- webpage %>%
    html_elements(css = "#reportable") %>%
    html_table()


elo_xpath <-
    "https://www.basketball-reference.com/wnba/players/a/augusse01w.html" |>
    read_html() |>
    html_elements(xpath = '//*[@id="per_game0"]') |>
    html_table()

identical(elo_class, elo_id)

##

url2 <- "https://footystats.org/england/premier-league"

xp <- '/html/body/div[3]/div/div[3]/div[3]/div/div/div/div[1]/table'

webpage2 <- read_html(url2)

webpage2 |>
    html_elements(xpath = xp) |>
    html_table()

##--- wikipedia : fifa world cup ----

url_wiki <- 'https://en.wikipedia.org/wiki/FIFA_World_Cup'
xpt_wiki <- '/html/body/div[3]/div[3]/div[5]/div[1]/table[3]'

page_wiki <- read_html(url_wiki)

## text from the webpage
page_wiki |>
    html_elements("p") |>
    html_text2()

## tables
page_wiki |>
    html_elements("table") |>
    html_table()

## selecting an specific table
tbl_wiki <-
    page_wiki |>
    html_element(xpath = xpt_wiki) |>
    html_table(dec = ",")

## dealing with double header
names(tbl_wiki) <- as.character(tbl_wiki[1, ])
tbl_wiki <- tbl_wiki[-1, ]

## removing "overall" row
tbl_wiki <- tbl_wiki[-nrow(tbl_wiki), ]

tbl_wiki <- janitor::clean_names(tbl_wiki)
    
tbl_wiki <-
    tbl_wiki |>
    mutate_at(c(1, 4:6), ~ as.numeric(gsub(",", "", .))) |>
    mutate(number = as.numeric(substr(gsub(",", "", number), 1, 6)))

ggplot(data = tbl_wiki,
       aes(x = year, y = avg_attendance)) +
    geom_line(lwd = 1.1) +
    geom_label(aes(label = hosts)) +
    theme_bw()

ggplot(data = tbl_wiki,
       aes(x = year, y = number)) +
    geom_line(lwd = 1.1) +
    ## geom_label(aes(label = gsub(",", "\n",venue))) +
    geom_label(aes(label = hosts)) +
    theme_bw()
