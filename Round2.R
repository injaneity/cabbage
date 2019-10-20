# Problem 2
orders <- data.frame(
  "orderid" <- c(),
  "buyer_userid" <- c(),
  "seller_userid" <- c()
)

devices <- data.frame(
  "userid" <- c(),
  "device" <- c()
)

credit_cards <- data.frame(
  "userid"<- c(),
  "credit_card" <- c()
)

credit_cards <- data.frame(
  "userid"<- c(),
  "bank_account" <- c()
)

# Initialise Items by Userid
userdevices <- list()
count = 0
for (i in unique(devices$userid)) {
  count = count + 1
  dev <- c(i, devices[which(devices$userid==currentid),"device"])
  userdevices[[count]] <- list(i, dev)
}





for (i in orders$orderid) {
  currentbuyer <- orders[i,"buyer_userid"]
  currentseller <- orders[i,"seller_userid"]
  orders$determination <- isFraud(currentbuyer, currentseller)
}

isFraud <- function (buyer, seller) {
  fraud = c()
  fraud[1] = checkFraud(userdevices, buyer, seller)
  fraud[2] = checkFraud(userccs, buyer, seller)
  fraud[3] = checkFraud(userbas, buyer, seller)
  if (any(fraud==TRUE) == TRUE) {
    judgement <- 1
  } else {
    judgement <- 0
  }
  return(judgement)
}

checkFraud <- function(masterlist, buyer, seller) {
  b <- masterlist[[which(sapply(test, function(e) is.element(buyer, e)))]][[2]]
  b <- sort(b)
  s <- master[[which(sapply(test, function(e) is.element(seller, e)))]][[2]]
  s <- sort(s)
  alldev <- c(b, s)
  if (any(duplicated(alldev)) == TRUE) {
    fraud = TRUE
  }
  return(fraud)
}

