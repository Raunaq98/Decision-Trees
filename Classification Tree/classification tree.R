# imported data as movies_c

# OUTLIERS
mean_time = mean(movies_c$Time_taken,na.rm = TRUE)
time_clean = function(x){
         out<- x
         if(is.na(x)){
                  out<- mean_time
         }else{
                  out<-x
         }
         out
}
movies_c$Time_taken<- sapply(movies_c$Time_taken,time_clean)

#### DATA SPLIT
library(caTools) 
set.seed(0)
sample<- sample.split(movies_c$Start_Tech_Oscar,SplitRatio = 0.8)
train_c<- subset(movies_c,sample==TRUE)
test_c<- subset(movies_c,sample==FALSE)

#### SIMPLE CLASSIFICATION TREE
library(rpart)
library(rpart.plot)

class_tree <- rpart(Start_Tech_Oscar~.,
                    data = train_c,
                    method = "class",
                    control = rpart.control(maxdepth = 3))

rpart.plot(class_tree,
           digits= -3)

#### PREDICTIONS
test_c$predictions <- predict(class_tree,
                            test_c,
                            type = "class")


#### CONFUSION MATRIX
table(test_c$Start_Tech_Oscar,test_c$predictions)
#    0  1
# 0 45  1
# 1 39 16

