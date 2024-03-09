from ucimlrepo import fetch_ucirepo 
from sklearn.tree import DecisionTreeClassifier, export_text
#Fetch the dataset
iris = fetch_ucirepo(id=53)
#Data (as pandas dataframes)
X = iris.data.features 
y = iris.data.targets
#Create a Decision Tree Classifier
tree_classifier = DecisionTreeClassifier(random_state=42)
#Fit the classifier to the data
tree_classifier.fit(X, y)
#Export the decision tree rules
tree_rules = export_text(tree_classifier, feature_names=X.columns)

print(tree_rules)
