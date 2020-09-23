# Decision Trees

A **decision tree** is a decision support tool that uses a tree-like model of decisions and their possible consequences, including chance event outcomes, resource costs, and utility. A decision tree is drawn upside down with its **root** at the top, which is the first internal node that performs the first split. It is a flowchart-like structure in which each **internal node** represents a "test" on an attribute (e.g. whether a coin flip comes up heads or tails), each **branch** represents the outcome of the test, and each **leaf** node represents a class label (decision taken after computing all attributes). The paths from root to leaf represent classification rules.

      ROOT ----> MULTIPLE INTERNAL NODES -----> CORRESPONDING LEAF OR INTERNAL NODES
      
With more than one attribute taking part in the decision-making process, it is necessary to decide the relevance and importance of each of the attributes, thus placing the most relevant at the root node and further traversing down by splitting the nodes. As we move further down the tree, the level of impurity or uncertainty decreases, thus leading to a better classification or best split at every node. To decide the same, splitting measures such as Information Gain, Gini Index, etc. are used.      
      
The decision tree can be a **regression tree** or a **classification tree**.

# Stopping Criteria

One of the most common problems of a decision tree is **over-fitting**. This can be avoided if we do not let the tree grow over a certain point. Three methods of stopping tree growth are:

      1. Minimum number of oberservations at an internal node.
      2. Maximum number of observations at an internal node.
      3. maximum depth of the tree.
      
# Regression Trees

All regression techniques contain a single output (response) variable and one or more input (predictor) variables. The output variable is numerical. The general regression tree building methodology allows input variables to be a mixture of continuous and categorical variables. A decision tree is generated when each decision node in the tree contains a test on some input variable's value. The terminal nodes of the tree contain the predicted output variable values.

A Regression tree may be considered as a variant of decision trees, designed to approximate real-valued functions, instead of being used for classification methods.

      STEP 1 : We divide the predictor space—that is, the set of possible values for
                  X1,...,Xp—into J distinct and non-overlapping regions, R1,...,RJ.
      STEP 2 : For every observation that falls into the region Rj , we make the same 
                  prediction, which is simply the mean of the response values for the training observations in Rj .
                  
                  The goal is to find regions such that RSS = sum(actual - predicted)² is minimum.

Suppose that in Step 1, we obtain two regions and that the response mean of the training observations in the first region is 10, while the response mean in the second region is 20. Then for a **given observation X = x**, we will predict a value of 10, and if x ∈ R2, we will predict a value of 20. The split of an attribute depends on the RSS value of all the combinations possible and choosing the minimum one. This is a **top-down greedy approach** as the best split at the current step is considered without taking into account the splits that lie ahead.

# Pruning of Regression Trees

Pruning reduces the size of decision trees by removing parts of the tree that do not provide power to classify instances. Decision trees are the most susceptible out of all the machine learning algorithms to overfitting and effective pruning can reduce this likelihood. 

We build a large tree and then cut parts of cut that are not benefitial to us. We can use cross validation but it leads to computational complexity. As a result, we use **Cost Complexity pruning**. 

One way to prevent over-fitting a regression tree to the training data is to remove some of the leaves and replace the split with leaf that is the average of a large number of observations.If we want to prune the tree more, we could remove last two leaves and replace the split with a leaf that is the average of a large number of observations. And again we could remove last two leaves and replace the split with a leaf that is the average of all of the observations.

The first step in cost complexity pruning is to calculate the sum of **squared residual (SSR)** for each tree. We will start with the original full size tree.
The value of SSR wwill always decrease as we keep reducing it's size. 

In order to properly evaluate different trees, we use a **complexity penalty Cp.T**
            
            where, Cp is the tuning parameter
                   T is the number of leaf nodes.
                                    
The **complexity parameter (cp)** is used to control the size of the decision tree and to select the optimal tree size. If the cost of adding another variable to the decision tree from the current node is above the value of cp, then tree building does not continue. We could also say that tree construction does not continue unless it would decrease the overall lack of fit by a factor of cp.

# Classification Trees

If one had to choose a classification technique that performs well across a wide range of situations without requiring much effort from the application developer while being readily understandable by the end-user a strong contender would be the **classification tree** methodology. Instead of using mean like that in Regression Trees, classification trees use the mode of the data.

# GINI Impurity

Gini index or Gini impurity measures the degree or probability of a particular variable being wrongly classified when it is randomly chosen. The degree of Gini index varies between 0 and 1, where 0 denotes that all elements belong to a certain class or if there exists only one class, and 1 denotes that the elements are randomly distributed across various classes. A Gini Index of 0.5 denotes equally distributed elements into some classes.

      GINI Impurity = 1 -  (probability of "YES")² -  (probability of "NO")²
      
| Past Trend | Open Interest | Trading Volume | Return |
|------| -------------|---------------|--------------|
|positive|low|high|up|
|negative|high|low|down|      
|positive|low|high|up| 
|positive|high|high|up| 
|negative|low|high|down| 
|positive|low|low|down| 
|negative|high|high|down| 
|negative|low|high|down| 
|positive|low|low|down| 
|positive|high|high|up|

      P( past trend = positive ) = 6/10
      P( past trend = negative ) = 4/10
      
      For past trend = positive, P(return = up ) = 4/6
                                 P( return = down) = 2/6
                                 GINI index = 1 -  (4/6)² - (2/6)²
                                            = 0.45
                                            
      For past trend = negative, GINI index = 1 - (0)² - (4/4)²
                                            = 0
                                            
      GINI index for past trend = (6/10)(0.45)  +  (4/10)(0)
                                = 0.27
            
| Attribute | GINI Index |
|------| -------------|
|past trend|0.27|
|open interest|0.47|
|trading volume|0.34|

From the above table, we observe that ‘Past Trend’ has the lowest Gini Index and hence it will be chosen as the root node for how decision tree works.
We will repeat the same procedure to determine the sub-nodes or branches of the decision tree.

# Bagging

The drawback of decision trees is that they dont tend to have the best prediction accuracy due to **high variance**.
**Bagging** is a general-purpose procedure for reducing the variance of a statistical learning method.

Here idea is to create several subsets of data from training sample chosen randomly with replacement. Now, each collection of subset data is used to train their decision trees. As a result, we end up with an ensemble of different models. Average of all the predictions from different trees are used which is more robust than a single decision tree.

# Random Forests

Building upon bagging , we use **random forests**. These are an ensemble of decision trees sampled from the training set with replacement.
Each time a tree is being sampled, a **random "m" features** are selected from the **total of "p" features**.
A fresh sample of m predictors is taken at each split and the split is allowed to use only one of those m predictors. 
           
           m  =  p / 3        for regression
           m  =  sqrt( p )    for classification
            
We use random forests because the presence of a strong feature can lead to correlated results in a bagged environment.
Random forests provide an improvement over bagged trees by way of a small tweak that **decorrelates the trees** and 
hence independent of each other.

Random forest adds additional randomness to the model, while growing the trees. Instead of searching for the most important feature while splitting a node, it searches for the best feature among a random subset of features. This results in a wide diversity that generally results in a better model.

