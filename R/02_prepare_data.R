##We have to fix the card identities starting from 0 instead of 1
rm(list=ls())
data_dir <- 'Data/df_raw.csv'
data <- read.csv(data_dir)
#sort observations chronologically
data <- data[order(
  data$subj,
  data$blk,
  data$trl
), ]

#keep valid card identities for inspection (frcA and frcB are the identity IDs of those cards)
data$card_left <- data$frcA + 1
data$card_right <- data$frcB + 1
data$chosen_card <- data$ch + 1

#binary choice: left = 0, right = 1
# ifelse is vectorized and it's Conditional Element Selection
data$choice <- ifelse(
  data$ch == data$frcB, 1,
  ifelse(data$ch == data$frcA, 0, NA)
)

