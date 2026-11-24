#=========================================================
#Project: Hierarchical reinforcement learning
#script: 01_explore_data.R
#Purpose: Explore trial-level behavioral data
#Data source: Ben-Artzi et al. (2023)
#DOI: 10.5061/dryad.d51c5b08d
#=========================================================
rm(list=ls())
data_dir <- 'Data/df_raw.csv'
data <- read.csv(data_dir)
head(data)
#General information about the data:
#examine structure
str(data)
#column names
names(data)
#number of observations and variables
dim(data)
#descriptive statistics
summary(data)
#number of participants
nSubjects <- length(unique(data$subj))
#reward outcomes and experimental conditions
table(data$rw, useNA='ifany')
table(data$cond)

##Examine one participant
subject_id<-unique(data$subj)[1]
sub01<-subset(data,subj==subject_id)
sub01<-sub01[order(sub01$blk,sub01$trl),]
head(sub01)
View(sub01)

#preliminary behavioral visualization 
hist(
  data$rt,
  main='distribution of reaction times',
  xlab='reaction times(ms)'
)
#frequency of choices:
barplot(
  table(data$ch),
  main='frequency of card choices',
  xlab='the card',
  ylab='number of choices'
)

