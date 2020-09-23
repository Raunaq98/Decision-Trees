# Decision Trees

A **decision tree** is a decision support tool that uses a tree-like model of decisions and their possible consequences, including chance event outcomes, resource costs, and utility. A decision tree is drawn upside down with its **root** at the top, which is the first internal node that performs the first split. It is a flowchart-like structure in which each **internal node** represents a "test" on an attribute (e.g. whether a coin flip comes up heads or tails), each **branch** represents the outcome of the test, and each **leaf** node represents a class label (decision taken after computing all attributes). The paths from root to leaf represent classification rules.

      ROOT ----> MULTIPLE INTERNAL NODES -----> CORRESPONDING LEAF OR INTERNAL NODES
      
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
