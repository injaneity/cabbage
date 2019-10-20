library(dplyr)

# Problem 2
devices <- fakedevices
credit_cards <- fakecards
bank_accounts <- fakeaccts
orders <- fakeorders

# Initialise Items by Userid
userdevices <- list()
count = 0
for (i in unique(devices$userid)) {
  count = count + 1
  dev <- devices[which(devices$userid==i),"device"]
  userdevices[[count]] <- list(i, dev)
}

userccs <- list()
count = 0
for (i in unique(credit_cards$userid)) {
  count = count + 1
  cc <- credit_cards[which(credit_cards$userid==i),"creditcard"]
  userccs[[count]] <- list(i, cc)
}

userbas <- list()
count = 0
for (i in unique(bank_accounts$userid)) {
  count = count + 1
  ba <- bank_accounts[which(bank_accounts$userid==i),"bankacct"]
  userbas[[count]] <- list(i, ba)
}

# Check fraud for one factor
checkFraud <- function(masterlist, buyer, seller) {
  fraud = FALSE
  b <- masterlist[[which(sapply(masterlist, function(e) is.element(buyer, e)))]][[2]]
  b <- pull(b, 1)
  b <- sort(b)
  s <- masterlist[[which(sapply(masterlist, function(e) is.element(seller, e)))]][[2]]
  s <- pull(s, 1)
  s <- sort(s)
  alldev <- c(b, s)
  if (any(duplicated(alldev)) == TRUE) {
    fraud = TRUE
  }
  return(fraud)
}

# Check fraud across device, cc, bacct
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

# Main Loop over OrderID
for (i in orders$orderid) {
  currentbuyer <- orders[which(orders$orderid == i),"buyer_userid"]
  currentseller <- orders[which(orders$orderid == i),"seller_userid"]
  orders[which(orders$orderid == i), "determination"] <- isFraud(currentbuyer, currentseller)
}