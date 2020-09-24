library(xgboost)

# xg boost required data in a certain format only


##### separating the dependent and independent variables

## training set

# the dependent variable should be in Boolean ie. TRUE/FALSE
train_xg_dependent <- train_c$Start_Tech_Oscar == 1

# independent variables cannot have categories and will need dummy variables
train_xg_indepdendent <- model.matrix(Start_Tech_Oscar~.,
                                      -1,       # remove the first dummy variable as well can do without it
                                      data = train_c)
train_xg_indepdendent<- train_xg_indepdendent[ ,-1]


## test set
test_xg_dependent <- test_c$Start_Tech_Oscar ==1
test_xg_indepdendent <- model.matrix(Start_Tech_Oscar~.,
                                      -1,      
                                      data = test_c)
test_xg_indepdendent<- test_xg_indepdendent[ ,-1]


## DMATRIX

matrix_train <- xgb.DMatrix(data = train_xg_indepdendent,
                            label = train_xg_dependent)

matrix_test <- xgb.DMatrix(data = test_xg_indepdendent,
                           label = test_xg_dependent)


## MODEL

xg_boosting <- xgboost(data = matrix_train,
                       nrounds = 50,
                       objective = "multi:softmax",   # we change this to change between regression and classification
                       eta = 0.3,                     # learning parameter between 0 and 1
                       num_class = 2,                 # multiclass classification, 2 in our case
                       max_depth = 100)

xg_pred <- predict(xg_boosting,matrix_test)
