# imported data as "moviess" with the dependent variable as "collection"

#### PRE PROCESSING

summary(movies)
# time_taken has 12 NAs
# twitter_hashtags has 2 upper outliers

#### OUTLIERS
mean_time = mean(movies$Movie_length,na.rm = TRUE)
time_clean = function(x){
         out<- x
         if(is.na(x)){
                  out<- mean_time
         }else{
                  out<-x
         }
         out
}
movies$Time_taken<- sapply(movies$Movie_length,time_clean)

#### DATA SPLIT
library(caTools)
set.seed(0)
sample<- sample.split(movies$Collection,SplitRatio = 0.8)
train<- subset(movies,sample==TRUE)
test<- subset(movies,sample==FALSE)

#### SIMPLE REGRESSION TREE
library(rpart)
library(rpart.plot)

reg_tree <- rpart(Collection~. ,
                  data = train,
                  control = rpart.control(maxdepth = 3))

rpart.plot(reg_tree,
           digits= -3)

#### PREDICTIONS
test$predictions <- predict(reg_tree,
                            test,
                            type = "vector")

MSE2 <- mean((test$Collection - test$predictions)^2)
# [1] 123905083

#### PRUNING

full_tree <- rpart(Collection~. ,
                    data = train,
                    control = rpart.control(cp=0))  # cp = 0 means tree grows to full length
rpart.plot(full_tree,digits= -3) # runs on different values of cp

# evaluating cp (alpha)
printcp(full_tree)  # gives error for corresponding cp
plotcp(full_tree)

# finding the value for cp for which relative error is minimum
mincp <- full_tree$cptable[which.min(full_tree$cptable[,"xerror"]),"CP"]

# pruning
prune_tree <- prune(full_tree, cp= mincp)
rpart.plot(prune_tree,digits = -3)


#### EVALUATING

test$pruned <- predict(prune_tree,test, type="vector")
MSE2pruned <- mean((test$Collection - test$pruned)^2)
#[1] 110996956

# hence, MSE2 value decresed from 123905083 to 110996956 after pruning.

