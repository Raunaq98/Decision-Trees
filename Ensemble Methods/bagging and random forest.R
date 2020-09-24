#### BAGGING      

library(randomForest)
set.seed(0)

bagged_tree <- randomForest(Collection ~.,
                            data = train,
                            mtry= 17)
# mtry= 17 tells that we want to use all of the variables present in the train set.
# had wwe wanted to to use less, it wouldve been the case of random forest.

test$bagging <- predict(bagged_tree,test)
MSE2_bagged <- mean((test$Collection-test$bagging)^2)
#[1] 94614813

# hence, MSE2 value decresed from 123905083 to 110996956 after pruning which
# further decreased to 94614813 after bagging.



#### RANDOM FOREST

library(randomForest)

rf_tree <- randomForest(Collection ~.,
                        data = train,
                        ntree=500)   # no need to mention mtry as it will get a random value

# predictions
test$rf <- predict(rf_tree,test)
MSE2_rf <- mean((test$Collection-test$rf)^2)
# [1] 54957317
# Reduced MSE2 from 94614813 in bagging to 54957317.



