import numpy as np
from sklearn.linear_model import LinearRegression

# Study Hours, Previous Score, Sleep Hours -> Final Score
X = np.array([
    [5, 70, 8],   # 5 hours study, 70 previous score, 8 hours sleep
    [3, 65, 6],
    [7, 80, 7],
    [4, 60, 5],
    [6, 75, 8],
    [8, 85, 7],
    [2, 55, 6],
    [9, 90, 8]
])

y = np.array([75, 68, 85, 65, 78, 88, 60, 92])  # Final scores

# Train model
model = LinearRegression()
model.fit(X, y)

print("Student Score Prediction Model")
print(f"Intercept: {model.intercept_:.2f}")
print(f"Coefficients: {model.coef_}")

# Predict for new student
new_student = [[6, 72, 7]]  # 6 hours study, 72 previous, 7 hours sleep
predicted_score = model.predict(new_student)
print(f"\nPredicted score: {predicted_score[0]:.2f}")