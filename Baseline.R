
# The Top 3 itemids (in a list) from the ‘Official Shop’ of that particular brand that generated the highest Gross Sales Revenue from 10th May to 31st May 2019.

Extra_material_2 <- data.frame("List of shop_id" = 1:270,
                               "brand" = sample(1:270, 270, rep=FALSE),
                               "shop_type" = sample(1:5, 270, rep=TRUE)
                               )

Extra_material_3 <- data.frame("List of orderid" = 1:1000, 
                               "itemid" = 1:1000, 
                               "date_id" = 1:1000, 
                               "amount" = sample(1:1000, 1000), 
                               "item_price_usd" = sample(1:10000, 1000), 
                               "shopid" = sample(1:270, 1000, rep=TRUE))

colnames(Extra_material_2)[which(colnames(Extra_material_2)=="List of shop_id")] <- "shop_id"
merged <- merge(Extra_material_2, Extra_material_3, by="")

Dummy <- read.csv("~/Desktop/cabbage/shopee-competition-page/Dummy data.csv")
Sol <- read.csv("~/Desktop/cabbage/shopee-competition-page/Solution.csv")

Dummy[, 2] <- Dummy[, 2]+1
colnames(Dummy)[2] <- "new_number"

write.csv(Sol, "Sol.csv", row.names=FALSE)
