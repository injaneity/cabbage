Extra_material_2 <- read.csv("~/Desktop/cabbage/ptr-rd1/Extra_material_2.csv")
Extra_material_2$shop_type <- NULL

Extra_material_3 <- read.csv("~/Desktop/cabbage/ptr-rd1/Extra_material_3.csv")

colnames(Extra_material_3)[colnames(Extra_material_3)=="shopid"] <- "shop_id"


library(dplyr)
Extra_material_2_clean <- distinct(Extra_material_2, .keep_all=TRUE)
Extra_material_3_clean <- distinct(Extra_material_3, .keep_all=TRUE)

length(unique(Extra_material_2_clean$brand))

length(unique(Extra_material_3_clean$brand))

merged<-data.frame()
merged <- merge(Extra_material_3_clean, Extra_material_2_clean, by="shop_id")
merged <- na.omit(merged)


merged[, "gross_revenue"] <- merged[, "amount"] * merged[, "item_price_usd"]

getTop3 <- function(merged_df) {
  Top <- data.frame(matrix(ncol=4))
  count = 0
  for (i in unique(merged_df$brand)) {
    count = count + 1
    temp <- merged_df[which(merged_df$brand==i),]
    temp <- temp[order(-temp$gross_revenue),]
    Top[count,] <- c(i, temp[1:3,"itemid"])
  }
  colnames(Top) <- c("brand", "Top1", "Top2", "Top3")
  return(Top)
}

Top3 <- getTop3(merged)

TopFinal <- data.frame("brand" = unique(Extra_material_2$brand))
TopFinal <- merge(TopFinal,Top3,  by="brand", all.x=TRUE)

TopFinal[, "Answers"] <- paste(TopFinal[,"brand"], TopFinal[,"Top1"], TopFinal[,"Top2"], TopFinal[,"Top3"], sep=", ")

Final <- data.frame("Index" = 1:270,
                    "Answers" = TopFinal[,"Answers"])

for (i in Final[,1]) {
  answers[i] <- gsub(", NA", "", toString(Final[i,2]))
}

Final <- data.frame("Index" = 1:270,
                    "Answers" = answers)
write.csv(Final, "answers2.csv", row.names=FALSE)
