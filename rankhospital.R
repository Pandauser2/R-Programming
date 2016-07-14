
rankhospital <- function(state="WA",outcome,num = "best") {
	data <-read.csv("outcome-of-care-measures.csv")
	st <- data[data$State == state,]  #filter by State
	rank <- NA
	if (tolower(outcome) == "heart attack"){
		ho <- st[order(as.numeric(as.character(st[,11])),as.character(st[,2])),] # order first by Col 11 rhn by Col 2
		ho <- ho[ho[,11]!= "Not Available",]
		ho$rank <- rank(as.numeric(as.character(ho[,11])), ties.method = "first") # Rank the ordered list and assign tie breaker
	}
	else if (tolower(outcome) == "heart failure") {
		ho <- st[order(as.numeric(as.character(st[,17])),as.character(st[,2])),]
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
     	
     	out <- as.character(ho[ho$rank == nrow(ho),][,"Hospital.Name"]) # worst rank is the total row number itself

     }
     else {
     	out <-as.character(ho[ho$rank == num,][,"Hospital.Name"])
     }
     out
}