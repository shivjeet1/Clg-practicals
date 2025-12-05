# Support Vector Machine (SVM) Classification — README

## Aim
To understand the basic theory of Support Vector Machine (SVM) for classification and implement it in Python using a simple dataset.

## Requirements
- Python 3.8+
- Installed packages:

```bash
pip install numpy pandas scikit-learn matplotlib
```

- Any IDE/notebook (VS Code, PyCharm, Jupyter, etc.)

---

## Theory (Concept + Intuition)
- **What is SVM?** A supervised learning algorithm that finds the **best separating hyperplane** between classes by maximizing the **margin** between them.
- **Support vectors:** Data points closest to the decision boundary; they directly influence the position and orientation of the hyperplane.
- **Margin:** Distance between the hyperplane and the nearest points from each class; SVM tries to maximize this margin.
- **Soft margin (C parameter):** Controls how much misclassification is allowed. Low `C` → wider margin, more tolerance to errors; high `C` → narrower margin, less tolerance.
- **Kernels:** Transform data into higher-dimensional spaces to make it linearly separable. Common kernels: `linear`, `rbf` (Gaussian), `poly` (polynomial).
- **When to use SVM:** Works well on medium-sized datasets with clear class separation; robust to high-dimensional feature spaces.

---

## Implementation (Step-by-Step in Python)

### 1. Import libraries
```python
import numpy as np
import pandas as pd
from sklearn import datasets
from sklearn.model_selection import train_test_split
from sklearn.preprocessing import StandardScaler
from sklearn.svm import SVC
from sklearn.metrics import accuracy_score, classification_report
import matplotlib.pyplot as plt
```

### 2. Load a sample dataset (Iris)
```python
iris = datasets.load_iris()
X = iris.data[:, :2]  # use only first 2 features for easy visualization
y = iris.target
```

### 3. Split into train and test
```python
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42, stratify=y
)
```

### 4. Feature scaling
```python
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)
```

### 5. Train an SVM classifier
```python
svm_clf = SVC(kernel='rbf', C=1.0, gamma='scale')
svm_clf.fit(X_train_scaled, y_train)
```

### 6. Evaluate the model
```python
y_pred = svm_clf.predict(X_test_scaled)
print('Accuracy:', accuracy_score(y_test, y_pred))
print(classification_report(y_test, y_pred, target_names=iris.target_names))
```

### 7. (Optional) Visualize decision boundaries
```python
import numpy as np

h = 0.02
x_min, x_max = X_train_scaled[:, 0].min() - 1, X_train_scaled[:, 0].max() + 1
y_min, y_max = X_train_scaled[:, 1].min() - 1, X_train_scaled[:, 1].max() + 1
xx, yy = np.meshgrid(np.arange(x_min, x_max, h),
                     np.arange(y_min, y_max, h))

Z = svm_clf.predict(np.c_[xx.ravel(), yy.ravel()])
Z = Z.reshape(xx.shape)

plt.contourf(xx, yy, Z, alpha=0.3)
plt.scatter(X_train_scaled[:, 0], X_train_scaled[:, 1], c=y_train, edgecolors='k')
plt.title('SVM Decision Boundary (RBF Kernel)')
plt.xlabel('Feature 1 (scaled)')
plt.ylabel('Feature 2 (scaled)')
plt.show()
```

---

## Conclusion
- SVM learns a hyperplane that maximizes the margin between classes, using only **support vectors** to define the boundary.
- The `C` and `kernel` parameters strongly affect performance and decision boundaries.
- With proper scaling and parameter tuning, SVM provides strong baseline results for many classification tasks, especially with clear separation between classes.

---

