# K-Nearest Neighbours (KNN) Classification

## Aim
To understand the working principle of the K-Nearest Neighbours (KNN) algorithm and implement KNN-based classification in Python using a standard dataset.

## Requirements
- Python 3.8+
- pip (or conda)
- Recommended libraries:

```bash
pip install numpy pandas scikit-learn matplotlib
```

---

## Theory (Concept + Basic Implementation Idea)
- KNN is a **lazy, instance-based** learning algorithm: it stores all training data and defers computation to prediction time.
- For a new sample, KNN finds the **K closest training points** (neighbors) using a distance metric (commonly Euclidean).
- The predicted class is usually decided by **majority vote** of these neighbors (for classification) or average (for regression).
- K is a hyperparameter: small K can lead to noisy, overfitted models; large K can oversmooth and underfit.
- **Feature scaling** (standardization/normalization) is important because KNN is distance-based.
- KNN works well on smaller, low-dimensional datasets and is easy to understand but can be slow with very large datasets.
- Common tunable aspects: K value, distance metric (Euclidean/Manhattan), and weighting (uniform vs distance-weighted neighbors).

---

## Implementation in Python (Step-by-step)

### 1. Import libraries
```python
import numpy as np
import pandas as pd
from sklearn.datasets import load_iris
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.neighbors import KNeighborsClassifier
from sklearn.metrics import accuracy_score, classification_report, confusion_matrix
```

### 2. Load and inspect dataset (Iris example)
```python
iris = load_iris()
X = iris.data          # features
y = iris.target        # labels
print('Feature shape:', X.shape)
print('Classes:', iris.target_names)
```

### 3. Train–test split
```python
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)
```

### 4. Feature scaling
```python
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)
```

### 5. Define and train KNN classifier
```python
k = 5  # you can tune this
knn = KNeighborsClassifier(n_neighbors=k, metric='minkowski', p=2)  # Euclidean
knn.fit(X_train_scaled, y_train)
```

### 6. Evaluate the model
```python
y_pred = knn.predict(X_test_scaled)
print('Accuracy:', accuracy_score(y_test, y_pred))
print('Confusion matrix:\n', confusion_matrix(y_test, y_pred))
print('Classification report:\n', classification_report(y_test, y_pred, target_names=iris.target_names))
```

### 7. Optional: Simple decision boundary visualization (2D slice)
> Note: This is just indicative; you typically visualise with 2 features for clarity.
```python
import matplotlib.pyplot as plt

X_2d = X_train_scaled[:, :2]
knn_2d = KNeighborsClassifier(n_neighbors=5)
knn_2d.fit(X_2d, y_train)

# create mesh grid
x_min, x_max = X_2d[:, 0].min()-1, X_2d[:, 0].max()+1
y_min, y_max = X_2d[:, 1].min()-1, X_2d[:, 1].max()+1
xx, yy = np.meshgrid(np.linspace(x_min, x_max, 200),
                     np.linspace(y_min, y_max, 200))
Z = knn_2d.predict(np.c_[xx.ravel(), yy.ravel()]).reshape(xx.shape)

plt.contourf(xx, yy, Z, alpha=0.3)
plt.scatter(X_2d[:, 0], X_2d[:, 1], c=y_train, edgecolor='k')
plt.xlabel('Feature 1 (scaled)')
plt.ylabel('Feature 2 (scaled)')
plt.title('KNN Decision Regions (2D)')
plt.show()
```

---

## Conclusion
- KNN classifies points based on the majority class among their nearest neighbors in feature space.
- Its performance depends heavily on **choice of K**, **distance metric**, and **proper feature scaling**.
- The algorithm is simple, interpretable, and strong for smaller datasets, but becomes computationally expensive on very large or high-dimensional data.
- This experiment demonstrated a complete KNN workflow: loading data, splitting, scaling, training, prediction and evaluation.

---

