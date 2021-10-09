library(rvest)
library(dplyr)

url_bet <- "https://www.nj.bet365.com/?_h=HJdWxF75g2O4lzMDddMZ-Q%3D%3D#/HO/"

wb_page <- read_html(url_bet)

wb_page |>
    html_elements("h")
