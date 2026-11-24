# load and prepare data ---------------------------------------------------
rm(list=ls())
data_dir <- 'Data/df_raw.csv'
data <- read.csv(data_dir)
#extract one subject
subject_id<-unique(data$subj)[1]
sub01<-subset(data,subj==subject_id)
#sort data chronologically 
sub01<-sub01[order(sub01$blk,sub01$trl),]
##prepare data of that one subject
#keep valid card identities for inspection (frcA and frcB are the identity IDs of those cards)
sub01$card_left <- sub01$frcA + 1
sub01$card_right <- sub01$frcB + 1
sub01$chosen_card <- sub01$ch + 1

# Missing responses have ch = -1
sub01$chosen_card <- ifelse(
  sub01$ch == -1,
  NA,
  sub01$ch + 1
)

#binary choice: left = 0, right = 1
# ifelse is vectorized and it's Conditional Element Selection
sub01$choice <- ifelse(
  sub01$ch == sub01$frcB, 1,
  ifelse(sub01$ch == sub01$frcA, 0, NA)
)

sub01$reward<-sub01$rw
sub01$block<-sub01$blk

#I'm not sure If I actually have to do this part but makeing trials start from 1
sub01$trial<-sub01$trl+1

#check the first trial
head(sub01[,c('block','trial','card_left','card_right','chosen_card','choice','reward')])


# prepare stan data -------------------------------------------------------------------
# Keep the complete trial sequence, including missing responses.
# -1 indicates an invalid choice.
# Missing rewards are assigned a placeholder of 0.
# Stan will ignore these trials


#exclude the subjects with NA
sub01 <- sub01[
  !is.na(sub01$choice) & !is.na(sub01$reward),
]
#check for NA
sum(is.na(sub01$choice))
sum(is.na(sub01$reward))

# actual part finally -_- -------------------------------------------------
#load libraries
#install.packages('rstan')
library(rstan)

nTrials <- nrow(sub01)
nBlocks <- length(unique(sub01$block))
nCards <- 4

dataList <- list(
  nTrials = nTrials,
  nBlocks = nBlocks,
  nCards = nCards,
  block = sub01$block,
  card_left = sub01$card_left,
  card_right = sub01$card_right,
  choice = sub01$choice,
  reward = sub01$reward
)

nIter<-2000
nChains<-4
nWarmup<-floor(nIter/2)
nThin<-1
modelFile<-'Stan/main_individual.stan'
fit_rl<-stan(
  modelFile,
  data=dataList,
  iter=nIter,
  warmup=nWarmup,
  chains=nChains,
  init='random',
  seed=12345
)



