# Decision Tree Classification & Regression

## Aim
To understand the intuition, core concepts, and Python implementation of the Decision Tree algorithm for **both classification and regression** problems using `scikit-learn`.

## Requirements
- Python 3.8+
- Libraries:
  - `numpy`, `pandas` for data handling
  - `scikit-learn` for Decision Tree models
  - `matplotlib` (optional) for simple visualization
- Install with:
```bash
pip install numpy pandas scikit-learn matplotlib
```

---

## Theory (Concepts + Implementation)

### 1. Core Idea
- A Decision Tree recursively splits the feature space into regions using simple rules like `feature <= threshold`.
- At each node, it chooses the split that best separates the data according to an impurity measure.
- Leaves store a final prediction: a class label (classification) or a numeric value (regression).

### 2. Impurity Measures
- **Classification:** uses criteria like Gini impurity or Entropy to measure how “mixed” the classes are in a node.
- **Regression:** typically uses Mean Squared Error (MSE) or Mean Absolute Error (MAE) to measure prediction error.
- The algorithm selects the split that most reduces impurity (i.e., maximizes information gain).

### 3. Model Complexity & Overfitting
- Deep trees can perfectly fit training data but overfit and generalize poorly.
- Control complexity using hyperparameters like `max_depth`, `min_samples_split`, `min_samples_leaf`.
- Pruning or limiting depth improves generalization and reduces variance.

### 4. Decision Tree for Classification — Example
```python
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.tree import DecisionTreeClassifier

X, y = load_iris(return_X_y=True)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

clf = DecisionTreeClassifier(criterion="gini", max_depth=3, random_state=42)
clf.fit(X_train, y_train)

print("Accuracy:", clf.score(X_test, y_test))
```
- This builds a shallow classification tree on the Iris dataset and prints test accuracy.

### 5. Decision Tree for Regression — Example
```python
import numpy as np
from sklearn.tree import DecisionTreeRegressor
from sklearn.model_selection import train_test_split

# Simple synthetic regression data
rng = np.random.RandomState(42)
X = np.sort(5 * rng.rand(80, 1), axis=0)
y = np.sin(X).ravel() + 0.1 * rng.randn(80)

X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
reg = DecisionTreeRegressor(max_depth=3, random_state=42)
reg.fit(X_train, y_train)

print("R^2 score:", reg.score(X_test, y_test))
```
- This fits a regression tree to noisy `sin(x)` data and reports the coefficient of determination.

### 6. Basic Plotting of Tree Predictions (Optional)
```python
import matplotlib.pyplot as plt

# For regression example above
X_grid = np.linspace(0, 5, 100).reshape(-1, 1)
y_pred = reg.predict(X_grid)

plt.scatter(X_train, y_train, label="train")
plt.plot(X_grid, y_pred, label="tree prediction")
plt.legend(); plt.xlabel("x"); plt.ylabel("y")
plt.show()
```
- Visualizing helps you see the piecewise-constant behavior of regression trees.

### 7. Practical Tips
- Scale is less critical than for linear models, but noisy or irrelevant features can still hurt performance.
- Always tune hyperparameters using cross-validation (e.g., `GridSearchCV` or `RandomizedSearchCV`).
- Trees are interpretable: inspect `feature_importances_` or export the tree structure for explanation.

---

## Conclusion
Decision Trees provide an interpretable, flexible model family for both classification and regression. They partition the feature space using simple, human-readable rules and can capture non-linear relationships without feature engineering. However, they tend to overfit if not properly regularized, and ensembles like Random Forests or Gradient Boosted Trees are often preferred for higher accuracy. This README gives you a compact reference and working Python snippets to experiment quickly.

---
