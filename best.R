
best <- function(state="WA",outcome) {
	data <-read.csv("outcome-of-care-measures.csv")
	st <- data[data$State == state,]
	if (tolower(outcome) == "heart attack"){
		ha <- st[order(as.numeric(as.character(st[,11])),as.character(st[,2])),]
		
	}
	else if (tolower(outcome) == "heart failure") {
		ha <- st[order(as.numeric(as.character(st[,17])),as.character(st[,2])),]
	}
	else if (tolower(outcome) == "pneumonia") {
		ha <-st[order(as.numeric(as.character(st[,23])),as.character(st[,2])),]

	}
	else { 
		print("enter valid outcome or state")
	}
	as.character(ha[1,2]) 
}