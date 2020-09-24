#### GRADIENT BOOSTING = regression as well ass classification
library(gbm)

set.seed(0)

gradient_boost <- gbm(Collection~.,
                      data= train,
                      distribution = "gaussian",   # gaussian for regression and bernoulli for classification
                      n.trees = 5000,
                      interaction.depth = 4,       # no. of levels in intermediate trees
                      shrinkage=0,                 # controls the learning rate = slow learning can lead to overfitting
                      verbose = F)                 # we dont want o/p at each itteration

test$gradient <- predict(gradient_boost,test,n.trees = 5000)

MSE2_gradient <- mean((test$Collection-test$gradient)^2)
# [1] 233693618




#### ADA BOOSTING = only classification
library(adabag)

# we need to work with factors
train_c$Start_Tech_Oscar <- as.factor(train_c$Start_Tech_Oscar)

ada_boost <- boosting(Start_Tech_Oscar~.,
                      data = train_c,
                      boos = TRUE) # if true, boosting will be done

predictions_ada <- predict(ada_boost,test_c)

table(test_c$Start_Tech_Oscar,predictions_ada$class)
#      0  1
#   0 27 19
#   1 16 39

# accuracy = 0.6534653
# plotting
t1 <- ada_boost$trees[[1]]
plot(t1)
text(t1,pretty=100)

#by default, there are only 100 iterations
ada_boost2 <- boosting(Start_Tech_Oscar~.,
                      data = train_c,
                      boos = TRUE,
                      mfinal = 1000)
predictions_ada2 <- predict(ada_boost2,test_c)

table(test_c$Start_Tech_Oscar,predictions_ada2$class)
#      0  1
#   0 31 15
#   1 15 40

#accuracy = 0.7029703



#### XG BOOSTING 