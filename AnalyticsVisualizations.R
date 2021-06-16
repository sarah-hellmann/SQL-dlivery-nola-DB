#to load the datasets
customer <- read.csv("C:\\Users\\elean\\onedrive\\Desktop\\customer.csv", header = TRUE)
delivery <- read.csv("C:\\Users\\elean\\onedrive\\Desktop\\delivery.csv", header = TRUE)
driver <- read.csv("C:\\Users\\elean\\onedrive\\Desktop\\driver.csv", header = TRUE)
items <- read.csv("C:\\Users\\elean\\onedrive\\Desktop\\items.csv", header = TRUE)
orderInfo <- read.csv("C:\\Users\\elean\\onedrive\\Desktop\\orderInfo.csv", header = TRUE)
orders <- read.csv("C:\\Users\\elean\\onedrive\\Desktop\\orders.csv", header = TRUE)
restaurant <- read.csv("C:\\Users\\elean\\onedrive\\Desktop\\restaurant.csv", header = TRUE)

#to answer the business questions
library(ggplot2)
library(tidyverse)

#Number of deliveries made by each driver?
driver_deliveries <- full_join(driver, delivery, by = "dID", copy = FALSE)
ggplot(driver_deliveries, aes(dName)) + geom_bar(width = 0.5, color = "pink", fill = "pink") + ggtitle("Number of Deliveries Completed by Each Driver") + theme_dark()

#Profits for each order
orderInfo <- orderInfo %>% mutate(totalOrderValue = itemPrice*itemQuantity)
options(scipen=999)
ggplot(orderInfo, aes(x=oID, y=totalOrderValue)) + geom_col(color = "pink", fill = "pink") + geom_text(aes(label=oID), vjust = 1.5, color = "black") + theme_dark() + ggtitle("Total Revenue from Each Order")

#Number of Orders from each restaurant
item_orders <- full_join(orderInfo, items, by = "itemID", copy = FALSE)
restaurant_orders <- full_join(restaurant, item_orders, by = "rID", copy = FALSE)
ggplot(restaurant_orders, aes(rName)) + geom_bar(width = 0.5, color = "pink", fill = "pink") + ggtitle("Number of Orders per Restaurant") + theme_dark()

#Number of orders per item
ggplot(restaurant_orders, aes(itemDescription)) + geom_bar(width = 0.5, color = "pink", fill = "pink") + ggtitle("Number of Orders per Item") + theme_dark()

