
rankall <- function(outcome, inputrank = 1) ### define the func
												{
	 data <- read.csv(
						"outcome-of-care-measures.csv", 
						colClasses=  c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"="character",
						"Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"="character",
						"Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"="character")
					)
	 	#not sure why but this has to be kept in one line
     data[,c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")]<-sapply(data[,c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")] , as.numeric )

    data <- data[order(data$State,data$Hospital.Name),] # sort the data by State then by Hospital Name in order to break ties with same rank

	Rank <- NA # best practice

		if (tolower(outcome) == "heart attack")
										{
											 	x <- split(data,data$State) # gets sorted by State because we will add this back to original
										 		y<- sapply(x,function(x)rank(x[,11],na.last= "keep", ties.method = "first")) # 11 is the Hear attack mortality rate column
										 		y <- unlist(y)
										 		y <- as.numeric(as.character(y))
										 		data$Rank <- y
										 
										}
	 else if (tolower(outcome) == "heart failure") {

	
											 	x <- split(data,data$State) # gets sorted by State because we will add this back to original
										 		y <- sapply(x,function(x)rank(x[,17],na.last= "keep", ties.method = "first")) # 17 is the heart failure mortality rate column
										 		y <- unlist(y)
										 		y <- as.numeric(as.character(y))
										 		print(dim(data))
										 		print(length(y))
										 		data$Rank <- y
										 
										}
	
	else if (tolower(outcome) == "pneumonia") {
										 	 	x <- split(data,data$State) # gets sorted by State because we will add this back to original
										 		y<- sapply(x,function(x)rank(x[,23],na.last= "keep", ties.method = "first")) # 23 is the pneumonia mortality rate column
										 		y <- unlist(y)
										 		y <- as.numeric(as.character(y))
										 		data$Rank <- y
										 
										}
			if  (inputrank == "best") {
		comp = merge(data.frame(State=unique(data$State)), data[data$Rank == 1,][,c("State","Hospital.Name","Rank")], all.x=T)  ####left join
		#print(head(comp))
			}
		else if  (inputrank == "worst") {
			df <- aggregate(Rank ~ State,data,max ) # Aggregates the data by State on max Rank
			df2 <- merge(df,data) # merges back to original Df, but state and rank is replaced by df
		comp = merge(data.frame(State=unique(data$State)), df2[,c("State","Hospital.Name","Rank")], all.x=T)  ####left join
			}
		else {
		comp = merge(data.frame(State=unique(data$State)), data[data$Rank == inputrank,][,c("State","Hospital.Name","Rank")], all.x=T) 
		}
     #comp <- data[data$Rank == inputrank,][,c("State","Hospital.Name","Rank")]   #dont need quote for input argument
     #print(comp[comp$State == "AK"],)
     #comp[!is.na(comp$State),]
}

