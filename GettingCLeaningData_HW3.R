#Question 1
agricultureLogical <- ams$ACR ==3 & ams$AGS == 6
which(agricultureLogical)[1:3]


#Question 2
img <- readJPEG("jeff.jpeg",native= TRUE)
quantile(img,probs=c(.3,.8))

#Question 3
# Read only two columns and 190 rows
cr <- read.csv("CountryRank.csv",colClasses= c(NA,NA,"NULL","NULL","NULL","NULL","NULL","NULL","NULL","NULL"),nrows=190,skip=4)
names(cr) <- c("CountryCode","Rank")
ce <- read.csv("CountryEducation.csv")
match <- merge(ce,cr)
match <- arrange(match, desc(Rank))
nrow(match)
#189
match[13,]
#St. Kitts and Nevis


#Question 4
result <- match %>% filter(Income.Group == "High income: OECD") %>% summarize(avg_Rank =mean(Rank))
> result
  avg_Rank
1 32.96667
result <- match %>% filter(Income.Group == "High income: nonOECD") %>% summarize(avg_Rank =mean(Rank))
 avg_Rank
1 91.91304

#Question 5
quantile(match$Rank, prob =seq(0,1,0.2), na.rm= TRUE) # breaking into 5 groups
cut(match$Rank, breaks=quantile(match$Rank, prob =seq(0,1,0.2), na.rm= TRUE))) # breaks in the data for five groups

match <- mutate(match, quartileRank = cut(match$Rank, breaks=quantile(match$Rank, prob =seq(0,1,0.2), na.rm= TRUE))) # adding a column

results2 <- match %>% filter(Rank <= 38) %>%filter(Income.Group =="Lower middle income") %>% summarize(count = n_distinct (CountryCode))
# visualize
aggregate(CountryCode ~  quartileRank +Income.Group, match, FUN= n_distinct)