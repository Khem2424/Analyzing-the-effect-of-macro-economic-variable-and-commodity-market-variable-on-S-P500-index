#----------------------------------------------------------------
# Economics Data Analysis Project
#
# Created:  11/18/2022
#
# Last Modified:  11/18/2022  
#
# Authors:  Deny Mishra, Miles S. Marimbire, Adita Sukla, Khem Bhatt 
# Associated Institution: University of Cincinnati
#----------------------------------------------------------------

#----------------------------------------------------------------
# This code is open source feel free to add any modification you wish
#----------------------------------------------------------------
# Set up R 
#----------------------------------------------------------------
# Clear environment, which means totally clear R environment
# of objects and loaded packages
rm(list=ls())
# To clear just the console window, type "Ctrl+L" or use Edit pull down menu

# Specify a display option
#options("scipen"=999, digits=2)

# === Set the working directory.  Note that R uses "/" not "\"
# === So the command is setwd("your directory path") or use the Session pull down menu
setwd("")
# === NOTE:  If using a MAC computer, you might need to replace the above command with something like
# === setwd("Desktop/R/")
#----------------------------------------------------------------

#----------------------------------------------------------------
# Install the packages
install.packages("rlang")
install.packages("httr")
install.packages("readxl")
install.packages("tidyverse")
install.packages("blsR")
install.packages("rvest")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("magrittr")
install.packages("zoo")
install.packages("yahoofinancer") 
install.packages("jsonlite")
install.packages("corrr")
install.packages("corrplot")

# List of packages 
library(corrr)
library(corrplot)
library(rlang)
library(httr)
library(readxl)
library(tidyverse)
library(blsR)
library(rvest)
library(dplyr)
library(ggplot2)
library(magrittr)
library(zoo)
library(yahoofinancer) 
library(jsonlite)



# Set the number of digits to display when using the jtools commands, like summ
options("jtools-digits"=4) 
options(scipen = 999)

# You can use these methods if you need a example of how to use a package
browseVignettes("AER")  # Short documents on how to use the packages
?mean # Opens the help page for the mean function
?"+" #  Opens the help page for addition
?"if" # Opens the help page for if, used for branching code
??plotting #  Searches for topics containing words like "plotting"
??"regression model" #  Searches for topics containing phrases like this
#--------------------------------------------------------

#--------------------------------------------------------
# Packages and Usage
#--------------------------------------------------------


#--------------------------------------------------------
# Data
#--------------------------------------------------------
# API Key
API="9dac204ee08e3bf18b4593492c39a336"

# Gross Domestic Product 
# Series ID - GDP
# Units - Billions of Dollars, Seasonally Adjusted Annual Rate
# Frequency - Quarterly

url = GET("https://api.stlouisfed.org/fred/series/observations?series_id=GDP&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
data = rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

gdp = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Gross Domestic Product "="value")

##############################

# Global price of Brent Crude
# Series ID - POILBREUSDQ
# Units - U.S. Dollars per Barrel,Not Seasonally Adjusted
# Frequency - Quarterly

url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=POILBREUSDQ&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

crude = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Brent Crude"="value")

##############################

# Consumer Price Index - All Items for the United States
# Series ID - USACPIALLMINMEI
# Units - Index 2015=100, Not Seasonally Adjusted
# Frequency - Quarterly

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=USACPIALLMINMEI&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

cpi = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Consumer Price Index"="value")

##############################

# Unemployment Rate 	
# Series ID - UNRATE
# Units - Percent, Seasonally Adjusted
# Frequency - Quarterly

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=UNRATE&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

unemp = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Unemployment Rate"="value")

##############################

# 10-Year Real Interest Rate 
# Series ID - REAINTRATREARAT10Y
# Units - Percent, Not Seasonally Adjusted
# Frequency - Quarterly

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=REAINTRATREARAT10Y&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

interest = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Interest Rate"="value")

##############################

# Producer Price Index by Commodity: All Commodities 
# Series ID - PPIACO
# Units - Index 1982=100, Not Seasonally Adjusted
# Frequency - Quarterly

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=PPIACO&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

ppi = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Producer Price Index "="value")

##############################

# S&P 500 
# Series ID - SP500
# Units - Index, Not Seasonally Adjusted
# Frequency - Daily, Close

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=SP500&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

SP500 = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("S&P 500"="value")

##############################

# S&P 500 
# Series ID - SP500
# Units - Index, Not Seasonally Adjusted
# Frequency - Daily, Close

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=SP500&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

SP500 = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("S&P 500"="value")

##############################

# Monetary Money Supply
# Series ID - M2SL
# Units - Billions of Dollars, Seasonally Adjusted
# Frequency - Monthly

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=M2SL&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

M2 = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Money Supply"="value")

##############################

# Real Gross Domestic Product
# Series ID - GDPC1
# Units - Billions of Chained 2012 Dollars, Seasonally Adjusted Annual Rate
# Frequency - Quarterly

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=GDPC1&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

real_gdp = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Real Gross Domestic Product"="value")

##############################

# Producer Price Index by Commodity: Metals and Metal Products: Gold Ores
# Series ID - WPU10210501
# Units - Index Jun 1985=100, Not Seasonally Adjusted
# Frequency - Monthly

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=WPU10210501&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)


# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

gold = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Gold Ores"="value")

##############################

# Real Disposable Personal Income: Per Capita 
# Series ID - A229RX0
# Units - Chained 2012 Dollars, Seasonally Adjusted Annual Rate
# Frequency - Monthly

# API GET request
url=GET("https://api.stlouisfed.org/fred/series/observations?series_id=A229RX0&frequency=q&api_key=9dac204ee08e3bf18b4593492c39a336&file_type=json")

# Check the status code ##### 200
url

# Get the variables content
rawToChar(url$content)

# Convert Json 
data = fromJSON(rawToChar(url$content))
names(data)

# Store values in variable
d = data$observations

personal = d %>%
  dplyr::select(-realtime_start, -realtime_end) %>%
  rename("Real Disposable Personal Income"="value")

##############################

# HUI Gold Index
#indice = Index$new('^HUI')
#gold_index = indice$get_history(start = '2010-01-01', interval = '1d')
##############################

# S&P 500 Index
#indice = Index$new('^GSPC')
#SP500_index = indice$get_history(start = '2010-01-01', interval = '1d')

##############################
# We must join all the data sets together
# We must use a nested join
df = left_join(gdp,crude, by="date") %>%
  left_join(.,cpi, by="date") %>%
  left_join(.,unemp, by="date") %>%
  left_join(.,interest, by="date")  %>%
  left_join(.,ppi, by="date") %>%
  left_join(.,SP500, by="date") %>%
  left_join(.,M2, by="date") %>%
  left_join(.,real_gdp, by="date") %>%
  left_join(.,gold, by="date") %>%
  left_join(.,personal, by="date")


# Slice the data set
df = df %>% slice(-c(1:288))

# Store data as a CSV file
#write.csv(df,"C:\\Users\\miles\\OneDrive\\Desktop\\Khem\\Econ6010_Data_Set.csv", row.names = FALSE)

#--------------------------------------------------------
# Data Analysis
#--------------------------------------------------------


#Filtering the entire data set based on pre-covid, during-covid and post covid
df$date = as.Date(df$date)

t_1 = df %>% filter(between(date, as.Date('2018-01-01'), as.Date('2019-10-30')))

t_2 = df %>% filter(between(date, as.Date('2019-11-01'), as.Date('2022-04-01'))) 

t_3 = df %>% filter(date > '2022-04-01')

##GGplot between GDP and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Gross Domestic Product `, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

# Correlation between selected variables using heat map


#correlation of variables before covid
f = data.frame( SandP = as.numeric (t_1$`S&P 500`), 
              gdp = as.numeric (t_1$`Real Gross Domestic Product`),
              cpi= as.numeric (t_1$`Consumer Price Index`),
              unemp_rate = as.numeric (t_1$`Unemployment Rate`),
              intrst_rate = as.numeric (t_1$`Interest Rate`),
              pp_index = as.numeric (t_1$`Producer Price Index`),
              M2 = as.numeric (t_1$`Money Supply`),
              crude =as.numeric (t_1$`Brent Crude`),
              gold_pr = as.numeric (t_1$`Gold Ores`),
              pci = as.numeric (t_1$`Real Disposable Personal Income`),
              
              stringsAsFactors = TRUE)




##Finding correlation and plotting correlation 
cor.table = cor(f)
print(cor.table)
corrplot(cor.table, 
         title = "Correlation between the varaibles- 20",
         bg = "black",
         method= "number")


##correlation between variables during covid

f1 = data.frame( SandP = as.numeric (t_2$`S&P 500`), 
                gdp = as.numeric (t_2$`Real Gross Domestic Product`),
                cpi= as.numeric (t_2$`Consumer Price Index`),
                unemp_rate1 = as.numeric (t_2$`Unemployment Rate`),
                intrst_rate1 = as.numeric (t_2$`Interest Rate`),
                pp_index = as.numeric (t_2$`Producer Price Index`),
                M2 = as.numeric (t_2$`Money Supply`),
                crude1 = as.numeric (t_2$`Brent Crude`),
                #gold_pr = as.numeric (t_2$`Gold Ores`), ##gold price is not availabe for those periods
                pci1 = as.numeric (t_2$`Real Disposable Personal Income`),
                
                stringsAsFactors = TRUE)

cor.table = cor(f1)
print(cor.table)
corrplot(cor.table, 
         title = "Correlation between the varaibles during covid",
         bg = "black",
         method= "number")


##GGplot between GDP and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Gross Domestic Product `, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between S&P500 and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `S&P 500`, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between Brenet Crude and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Brent Crude`, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between CPI and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Consumer Price Index`, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between Umemployment rate and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Unemployment Rate`, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between INterest Rate and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Interest Rate`, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between Producers Price Index and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Producer Price Index `, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between Money Supply and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Money Supply`, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between Gold Ores and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Gold Ores`, group=1)) + 
  scale_x_date(date_labels="%m/%Y")

##GGplot between Real Disposable Income and date
df %>%
  ggplot() +
  geom_line(mapping=aes(x = as.Date(date), y = `Real Disposable Personal Income`, group=1)) + 
  scale_x_date(date_labels="%m/%Y")


# Correlation between selected variables using heat map
##first converting every data set of df into numeric and saving in f2 data frame.

f2 = data.frame( SandP = as.numeric (df$`S&P 500`), 
                 Rgdp = as.numeric (df$`Real Gross Domestic Product`),
                 Brentcrude = as.numeric(df$`Brent Crude`),
                 ConsumerPrice = as.numeric(df$`Consumer Price Index`),
                 unemployment_rate = as.numeric(df$`Unemployment Rate`),
                 interst_rate = as.numeric(df$`Interest Rate`),
                 producer_price = as.numeric(df$`Producer Price Index `),
                 money_supply = as.numeric(df$`Money Supply`),
                 gold_price = as.numeric(df$`Gold Ores`),
                 PCI = as.numeric(df$`Real Disposable Personal Income`),
 stringsAsFactors = TRUE)

plot(f2$Rgdp, f2$SandP, pch = 19, col = "black")
    # Linear fit
    abline(lm(f2$SandP ~ f2$Rgdp))
    # Smooth fit
    lines(lowess(f2$Rgdp, f2$SandP), col = "blue", lwd = 3)
                
plot(f2$Brentcrude, f2$SandP, pch = 19, col= "black")
    # Linear fit
   abline(lm(f2$SandP ~ f2$Brentcrude))
    # Smooth fit
    lines(lowess(f2$Brentcrude, f2$SandP), col = "blue", lwd = 3)
    
plot(f2$ConsumerPrice, f2$SandP, pch = 19, col= "black")
    # Linear fit
    abline(lm(f2$SandP ~ f2$ConsumerPrice))
    # Smooth fit
    lines(lowess(f2$ConsumerPrice, f2$SandP), col = "blue", lwd = 3)


plot(f2$unemployment_rate, f2$SandP, pch = 19, col="black")
    # Linear fit
    abline(lm(f2$SandP ~ f2$unemployment_rate))
    # Smooth fit
    lines(lowess(f2$unemployment_rate, f2$SandP), col = "blue", lwd = 3)

plot( f2$interst_rate, f2$SandP, pch = 19, col="black")
   # Linear fit
  abline(lm(f2$SandP ~ f2$interst_rate))
  # Smooth fit
  lines(lowess(f2$interst_rate, f2$SandP), col = "blue", lwd = 3)

plot( f2$producer_price,f2$SandP,pch = 19, col="black")
  # Linear fit
  abline(lm(f2$SandP ~ f2$producer_price))
  # Smooth fit
  lines(lowess(f2$producer_price, f2$SandP), col = "blue", lwd = 3)

plot( f2$money_supply, f2$SandP, pch = 19, col="black")
  # Linear fit
  abline(lm(f2$SandP ~ f2$money_supply))
  # Smooth fit
  lines(lowess(f2$money_supply, f2$SandP), col = "blue", lwd = 3)

plot( f2$gold_price,f2$SandP, pch = 19, col="black")
  # Linear fit
  abline(lm(f2$SandP ~ f2$gold_price))
  # Smooth fit
  lines(lowess(f2$gold_price, f2$SandP), col = "blue", lwd = 3) #######This is not working ?????find it????????
 
plot(f2$PCI, f2$SandP, pch = 19, col="black")
  # Linear fit
  abline(lm(f2$SandP ~ f2$PCI))
  # Smooth fit
  lines(lowess(f2$PCI, f2$SandP), col = "blue", lwd = 3)

                
                
                
                
                
                

