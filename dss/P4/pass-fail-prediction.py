import numpy as np
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score, classification_report

# Study Hours, Attendance%, Previous Score -> Pass(1) or Fail(0)
X = np.array([
    [2, 60, 45],   # 2 hours study, 60% attendance, 45 previous score
    [5, 85, 70],
    [3, 70, 55],
    [7, 90, 80],
    [1, 50, 40],
    [6, 88, 75],
    [4, 75, 65],
    [8, 95, 85],
    [2, 55, 50],
    [5, 80, 72],
    [3, 65, 58],
    [7, 92, 82],
    [1, 48, 38],
    [6, 87, 77],
    [4, 78, 68]
])

y = np.array([0, 1, 0, 1, 0, 1, 1, 1, 0, 1, 0, 1, 0, 1, 1])  # 0=Fail, 1=Pass

print("Student Pass/Fail Prediction")
print("="*50)

# Train model
model = LogisticRegression()
model.fit(X, y)

# Model coefficients
print("\nModel Coefficients:")
print(f"  Study Hours: {model.coef_[0][0]:.4f}")
print(f"  Attendance: {model.coef_[0][1]:.4f}")
print(f"  Previous Score: {model.coef_[0][2]:.4f}")

# Predictions on training data
predictions = model.predict(X)
accuracy = accuracy_score(y, predictions)
print(f"\nTraining Accuracy: {accuracy:.2%}")

# Predict for new students
print("\n--- New Student Predictions ---")
new_students = [
    [4, 72, 62],  # Student 1
    [7, 88, 78],  # Student 2
    [2, 58, 48]   # Student 3
]

for i, student in enumerate(new_students, 1):
    prediction = model.predict([student])
    probability = model.predict_proba([student])
    
    print(f"\nStudent {i}: Study={student[0]}hrs, Attend={student[1]}%, Score={student[2]}")
    print(f"  Prediction: {'PASS ✓' if prediction[0] == 1 else 'FAIL ✗'}")
    print(f"  Pass Probability: {probability[0][1]:.2%}")