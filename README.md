# Decision Trees

A **decision tree** is a decision support tool that uses a tree-like model of decisions and their possible consequences, including chance event outcomes, resource costs, and utility. A decision tree is drawn upside down with its **root** at the top, which is the first internal node that performs the first split. It is a flowchart-like structure in which each **internal node** represents a "test" on an attribute (e.g. whether a coin flip comes up heads or tails), each **branch** represents the outcome of the test, and each **leaf** node represents a class label (decision taken after computing all attributes). The paths from root to leaf represent classification rules.

      ROOT ----> MULTIPLE INTERNAL NODES -----> CORRESPONDING LEAF OR INTERNAL NODES
      
With more than one attribute taking part in the decision-making process, it is necessary to decide the relevance and importance of each of the attributes, thus placing the most relevant at the root node and further traversing down by splitting the nodes. As we move further down the tree, the level of impurity or uncertainty decreases, thus leading to a better classification or best split at every node. To decide the same, splitting measures such as Information Gain, Gini Index, etc. are used.      
      
The decision tree can be a **regression tree** or a **classification tree**.

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


The drawback of decision trees is that they dont tend to have the best prediction accuracy due to **high variance**.
**Bagging** is a general-purpose procedure for reducing the variance of a statistical learning method.


Building upon bagging , we use **random forests**. These are an ensemble of decision trees sampled from the training set with replacement.
Each time a tree is being sampled, a **random "m" features** are selected from the **total of "p" features**.
A fresh sample of m predictors is taken at each split and the split is allowed to use only one of those m predictors. 
           
           m  =  sqrt( p )
            
We use random forests because the presence of a strong feature can lead to correlated results in a bagged environment.
Random forests provide an improvement over bagged trees by way of a small tweak that **decorrelates the trees** and 
hence independent of each other.

The **complexity parameter (cp)** is used to control the size of the decision tree and to select the optimal tree size. If the cost of adding another variable to the decision tree from the current node is above the value of cp, then tree building does not continue. We could also say that tree construction does not continue unless it would decrease the overall lack of fit by a factor of cp.
