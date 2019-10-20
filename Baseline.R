# Dummy Solution
Dummy <- read.csv("~/Desktop/cabbage/shopee-competition-page/Dummy data.csv")
Sol <- read.csv("~/Desktop/cabbage/shopee-competition-page/Solution.csv")

Dummy[, 2] <- Dummy[, 2]+1
colnames(Dummy)[2] <- "new_number"

write.csv(Sol, "Sol.csv", row.names=FALSE)

# First "Problem"
## The Top 3 itemids (in a list) from the ‘Official Shop’ of that particular brand that generated the highest Gross Sales Revenue from 10th May to 31st May 2019.
Extra_material_2 <- data.frame("List of shop_id" = 1:270,
                               "brand" = sample(1:270, 270, rep=FALSE),
                               "shop_type" = sample(1:5, 270, rep=TRUE)
                               )

Extra_material_3 <- data.frame("List of orderid" = 1:1000, 
                               "itemid" = 1:1000, 
                               "date_id" = 1:1000, 
                               "amount" = sample(1:1000, 1000), 
                               "item_price_usd" = sample(1:10000, 1000), 
                               "shop_id" = sample(1:270, 1000, rep=TRUE))

# Merge and create gross_revenue column
merged <- merge(Extra_material_2, Extra_material_3, by="shop_id")
merged[, "gross_revenue"] <- merged[, "amount"] * merged[, "item_price_usd"]

getTop3 <- function(merged_df) {
  Top <- data.frame(matrix(ncol=4))
  count = 0
  for (i in unique(merged_df$shop_id)) {
    count = count + 1
    temp <- merged_df[which(merged_df$shop_id==i),]
    temp <- temp[order(-temp$gross_revenue),]
    Top[count,] <- c(i, temp[1:3,"itemid"])
  }
  return(Top)
}

Top3 <- getTop3(merged)



# Problem 3
isFraud <- function(buyer_userid, seller_userid) {
  temp1 <- credit_cards[which(credit_cards$userid == buyer_userid),]
}