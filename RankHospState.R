
rankall <- function(outcome,num = "best") 
														{
	data <-read.csv("outcome-of-care-measures.csv", colClasses= c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack"="character","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure"="character","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia"="character"))

  data[,c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")]<-  sapply(data[,c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia")],as.numeric )
 
	rank <- NA
	if (tolower(outcome) == "heart attack"){
		outcome <- tapply(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,data$State,order)
		ties <- tapply(data$Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack,data$State,order)
		ho <- ho[ho[,11]!= "Not Available",]
		ho$rank <- rank(as.numeric(as.character(ho[,11])), ties.method = "first")
	}
	else if (tolower(outcome) == "heart failure") {
		ho <- data[order(data[,7],data[,17],st[,2]),]
		ho <- ho[ho[,17] != "Not Available",]
		ho$rank <- rank(as.numeric(as.character(ho[,17])), ties.method ="first")
	}
	else if (tolower(outcome) == "pneumonia") {
		ho <-st[order(as.numeric(as.character(st[,23])),as.character(st[,2])),]
		ho <- ho[ho[,23] != "Not Available",]
	   ho$rank <- rank(as.numeric(as.character(ho[,23])), ties.method ="first")
	}
	else { 
		print("enter valid outcome or state")
	}
	
	if (num == "best"){	
		 out <- as.character(ho[ho$rank == 1,][,"Hospital.Name"])
		}
     else if (num == "worst") {
     	
     	out <- as.character(ho[ho$rank == nrow(ho),][,"Hospital.Name"])

     }
     else {
     	out <-as.character(ho[ho$rank == num,][,"Hospital.Name"])
     }
     out
}


sorted <- data %>% 
          arrange(data[,7], -data[,17]) %>%
          group_by(data[,7]) %>%
          mutate(rank=row_number())
print.data.frame(sorted)




data$Rank <- unlist(with(data, tapply(data[,17], data$State,function(x)rank(x,na.last="keep",ties.method="first"))))
