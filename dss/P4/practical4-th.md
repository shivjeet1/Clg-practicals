# Logistic Regression Classification in Python

## Aim
To understand the basic theory of Logistic Regression and implement a binary classification model in Python using both scikit-learn and a minimal from-scratch formulation.

---

## Requirements
- Python 3.8+
- Recommended libraries:
  - `numpy` (numerical operations)
  - `pandas` (data handling)
  - `matplotlib` (visualization)
  - `scikit-learn` (logistic regression implementation)
- Install via:

```bash
pip install numpy pandas matplotlib scikit-learn
```

---

## Theory (Concept + Implementation)

### 1. Core Idea
- Logistic Regression is a **binary classification** algorithm, not a regression algorithm in practice.
- It models the **probability** that a sample belongs to the positive class (e.g., `y = 1`).
- The decision is made by applying a **threshold** (typically 0.5) on that probability.

Mathematically:
- Linear combination: \( z = w^T x + b \)
- Sigmoid (logistic) function: \( \sigma(z) = \frac{1}{1 + e^{-z}} \)
- Model output: \( \hat{y} = P(y=1|x) = \sigma(w^T x + b) \)

### 2. Learning the Parameters
- Parameters \(w, b\) are learned by **maximizing the likelihood** (equivalently **minimizing log-loss**):
  - Loss per sample: \( L(\hat{y}, y) = -[y \log(\hat{y}) + (1-y) \log(1-\hat{y})] \)
- Optimization is typically done using **gradient descent** or variants (e.g., in scikit-learn: LBFGS, liblinear).
- Regularization (L2 by default) helps prevent overfitting.

---

## Implementation in Python (scikit-learn)

### 1. Using a Real Dataset (Breast Cancer)
```python
import numpy as np
import pandas as pd
from sklearn.datasets import load_breast_cancer
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report

# 1. Load data
data = load_breast_cancer()
X = data.data
y = data.target  # 0 = malignant, 1 = benign

# 2. Train/test split
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42, stratify=y
)

# 3. Define and train model
model = LogisticRegression(max_iter=1000)
model.fit(X_train, y_train)

# 4. Predictions and evaluation
y_pred = model.predict(X_test)
print("Accuracy:", accuracy_score(y_test, y_pred))
print(classification_report(y_test, y_pred))
```
**What happens here (step-wise from your POV):**
1. Dataset with features (`X`) and labels (`y`) is loaded.
2. Data is split to avoid training and testing on the same samples.
3. `LogisticRegression` learns weights that map features to class probabilities.
4. `predict` applies a 0.5-like threshold internally to output class labels.

---

## Minimal From-Scratch Illustration (Gradient Descent)

> This is intentionally simplified to show the learning mechanism, **not** for production use.

```python
import numpy as np

# Sigmoid
def sigmoid(z):
    return 1 / (1 + np.exp(-z))

# Binary cross-entropy loss
def loss(y, y_hat):
    eps = 1e-9
    return -np.mean(y * np.log(y_hat + eps) + (1 - y) * np.log(1 - y_hat + eps))

# Fake toy data (2D features)
np.random.seed(0)
X = np.random.randn(100, 2)
true_w = np.array([2.0, -1.0])
true_b = 0.5
probs = sigmoid(X @ true_w + true_b)
y = (probs > 0.5).astype(int)

# Initialize params
w = np.zeros(2)
b = 0.0
lr = 0.1

for epoch in range(1000):
    z = X @ w + b
    y_hat = sigmoid(z)

    # Gradients
    dw = X.T @ (y_hat - y) / len(X)
    db = np.mean(y_hat - y)

    # Parameter update
    w -= lr * dw
    b -= lr * db

print("Learned w:", w)
print("Learned b:", b)
print("Final loss:", loss(y, y_hat))
```
**Understanding the loop from your POV:**
- Each epoch computes predictions `y_hat` given current parameters.
- The gradient shows how to adjust `w` and `b` to reduce loss.
- Repeated updates push probabilities closer to the true labels.

---

## Conclusion
- Logistic Regression is a **probabilistic linear classifier** that uses the sigmoid function to map inputs to [0, 1].
- Its training optimizes a convex log-loss, making it relatively stable and interpretable (feature weights have clear meaning).
- Using scikit-learn, implementation is concise and suitable for baselines; the from-scratch example clarifies how gradient descent updates actually work.

---


