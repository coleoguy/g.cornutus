# Athena Meyer
# Heath Blackmon
# coleoguy#gmail.com

# this function take the format the microscope gives:
# left horn beetle 1
# right horn beetle 1
# body length beetle 1
# left horn beetle 2
# right horn beetle 2
# body length beetle 2
# and changes it to the format that we want:
# beetle1   horn     body

FixData <- function(data){
  if(nrow(data)/3 != round(nrow(data)/3)) stop("wrong number of rows")
  new.data <- as.data.frame(matrix(,1,3))
  counter <- 1
  for(i in seq(from = 1, to = nrow(data), by = 3)){
    new.data[counter, 1:3] <- c(data[i,2],                      ## beetle number
                                mean(data[i,1], data[(i+1),1]), ## mean horn
                                data[(i+2),1])                  ## body size
    counter <- counter + 1
  }
  colnames(new.data) <- c("vial", "horn", "body")
  return(new.data)
}

####
#### This function calculates the high and low line selection
#### This function is largely the same as is contained in evobiR

ResSel <- function(data, traits, percent = 10, identifier=1, model = "linear"){
  ## fit a linear model
  lm.norm <- lm(data[,traits[2]] ~ data[,traits[1]])
  ## rank the residuals
  foo<-rank(lm.norm$residuals)
  ## calculate the high and low lines
  high <- data[foo > (nrow(data) - (nrow(data) * 0.01 * percent)), 1]
  low <- data[foo < (nrow(data) * .01 * percent), 1]
  
  ## lets plot the data just for grins
  plot(data[,traits[1]:traits[2]], pch=19, cex=.5, main=paste("Top and Bottom ",percent,"%",sep=""), col="gray")
  points(data[foo>(nrow(data)-(nrow(data)*.01*percent)),traits[1]:traits[2]],col="blue",pch=19,cex=1.1)
  points(data[foo<(nrow(data)*.01*percent),traits[1]:traits[2]],col="red",pch=19,cex=1.1)
  abline(lm.norm, col='orange', lwd=5)
  
  ## set up a list to return to user
  results <- list()
  results[[1]] <- high
  results[[2]] <- low
  names(results) <- c('high line', 'low line')
  return(results)
}