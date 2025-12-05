# Multiple Linear Regression in Python

## Aim
To understand the concept of **multiple linear regression** and implement a simple model in Python using real or synthetic data, evaluate its performance, and interpret basic results.

---

## Requirements
- Python 3.8+
- Recommended libraries:
  - `numpy`, `pandas`, `matplotlib`, `scikit-learn`
- Install via:

```bash
pip install numpy pandas matplotlib scikit-learn
```

---

## Theory (Short & Practical)
Multiple linear regression models a continuous target variable `y` as a linear combination of **multiple** predictors `x₁, x₂, …, xₚ`:

\[ y = β₀ + β₁x₁ + β₂x₂ + … + βₚxₚ + ε \]

Key ideas (in simple terms):
1. **Goal:** Find coefficients (βs) that minimize the squared difference between predicted and actual `y` (ordinary least squares).
2. **Inputs:** Multiple numeric or suitably encoded features (e.g., size, rooms, age for house price).
3. **Outputs:** A fitted line in multi-dimensional space and metrics like R², MAE, MSE to judge fit.
4. **Assumptions (basic):** Rough linear relationship, no severe multicollinearity, errors with mean zero and constant variance.
5. **Use cases:** Price prediction, demand forecasting, basic risk/score models.

---

## Implementation — Simple End-to-End Example

### 1. Import libraries
```python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.linear_model import LinearRegression
from sklearn.metrics import r2_score, mean_absolute_error
```

### 2. Create or load data (example: synthetic house-prices-like data)
```python
# Synthetic dataset: price ~ 50*size + 10*rooms + noise
np.random.seed(42)
size = np.random.randint(500, 2000, 100)      # square feet
rooms = np.random.randint(1, 5, 100)         # number of rooms
noise = np.random.normal(0, 10000, 100)
price = 50 * size + 10000 * rooms + noise

# Put into a DataFrame
df = pd.DataFrame({
    'size': size,
    'rooms': rooms,
    'price': price
})
```

### 3. Split into features (X) and target (y), then train/test sets
```python
X = df[['size', 'rooms']]   # predictors
y = df['price']             # target

X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)
```

### 4. Fit a multiple linear regression model
```python
model = LinearRegression()
model.fit(X_train, y_train)

print("Intercept (β0):", model.intercept_)
print("Coefficients (β1, β2, ...):", model.coef_)
```

### 5. Make predictions and evaluate the model
```python
y_pred = model.predict(X_test)

r2 = r2_score(y_test, y_pred)
mae = mean_absolute_error(y_test, y_pred)

print("R² score:", r2)
print("Mean Absolute Error:", mae)
```

### 6. Quick diagnostic plot (predicted vs. actual)
```python
plt.scatter(y_test, y_pred)
plt.xlabel('Actual Price')
plt.ylabel('Predicted Price')
plt.title('Multiple Linear Regression: Actual vs Predicted')
plt.grid(True)
plt.tight_layout()
plt.savefig('mlr_actual_vs_predicted.png')
```

Interpretation tips (in your POV as a learner):
1. **R² close to 1** ⇒ model explains most variance; closer to 0 ⇒ weak linear fit.
2. **MAE small** relative to the scale of `y` ⇒ predictions reasonably accurate.
3. Coefficients show how much `y` changes per unit change in each feature, holding others constant.
4. The scatter plot near a 45° line indicates good agreement between actual and predicted values.

---

## Conclusion
In this experiment, you:
1. Defined the goal of multiple linear regression and its basic math form.
2. Created a small dataset with two predictors and one continuous target.
3. Split data into training and testing sets for honest evaluation.
4. Trained a `LinearRegression` model from scikit-learn.
5. Evaluated the model using R² and MAE and visualized predictions.
6. Interpreted coefficients and predictions in simple, practical terms.


---

