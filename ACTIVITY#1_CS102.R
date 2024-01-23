library(ggplot2)
library(dplyr)
library(polite)
library(xml2)
library(magrittr)
library(rvest)
library(httr)

polite::use_manners(save_as = "polite_scrape.R")
url <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225007011&rh=n%3A16225007011%2Cn%3A3012292011&ref=nav_em__nav_desktop_sa_intl_external_components_0_2_6_6'
session <- bow(url, user_agent = "Educational")


brandDescription <- character(0)
numStars <- character(0)
price <- character(0)
numReviews <- character(0)

#Brandname Scrape
numStars <- scrape(session) %>%
  html_nodes('span.a-icon-alt')%>%
  html_text

#Price scrape
price <- scrape(session) %>%
  html_nodes('span.a-price-whole') %>%
  html_text

#Reviews Scrape
numReviews <- scrape(session) %>%
  html_nodes('span.a-size-base.s-underline-text') %>%
  html_text

#Brand and Descrption Scrape
brandDescription <- scrape(session) %>%
  html_nodes('span.a-size-base-plus') %>%
  html_text


removeRows <- c(1,5,7,9,11,14,16,18,20,25,27,30,32,35,37,39,41,43,45,47,49,51,54,56)
brandDescription <- brandDescription[-removeRows]
brandDescription    


extCompDF <- data.frame(
              Category <- rep("External Components",33),
              Brand_Description = brandDescription,
              Number_of_Reviews =  numReviews,
              Price = price,
              Number_of_Stars = numStars
              
)
View(extCompDF)
write.csv(extCompDF, "C:/Users/student/Desktop/act1 cs102/Activity1.csv", row.names=FALSE)
 

url2 <- 'https://www.amazon.com/s?i=specialty-aps&bbn=16225009011&rh=n%3A%2116225009011%2Cn%3A172541&ref=nav_em__nav_desktop_sa_intl_headphones_0_2_5_8'
session2 <- bow(url2, user_agent = "Educational")

brandDescription2 <- character(0)
numStars2 <- character(0)
price2 <- character(0)
numReviews2 <- character(0)

brandDescription2 <- scrape(session2) %>%
    html_nodes('span.a-size-base-plus') %>%
    html_text

numStars2 <- scrape(session2) %>%
  html_nodes('span.a-icon-alt') %>%
  html_text

price2 <- scrape(session2) %>%
  html_nodes('span.a-price-whole') %>%
  html_text

numReviews2<- scrape(session2) %>%
  html_nodes('span.a-size-base.s-underline-text') %>%
  html_text

price2 <- c("NA",price2)
HeadPhonesDF <- data.frame(
  Category = rep("HeadPhones & Earbuds",33),
  Brand_Description = brandDescription2,
  Number_of_Reviews = numReviews2,
  Price = price2,
  Number_of_Stars = numStars2
  
)
HeadPhonesDF

combinedDF <- data.frame(
  Category = c(rep("External Components",33),rep("HeadPhones & Earbuds",33),
  Brand_Description            
  
)