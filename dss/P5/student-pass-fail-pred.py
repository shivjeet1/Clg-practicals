import numpy as np
import pandas as pd
from sklearn.neighbors import KNeighborsClassifier
from sklearn.model_selection import train_test_split
import matplotlib.pyplot as plt

# Dataset: Study Hours, Attendance(%) -> Pass(1) or Fail(0)
data = {
    'Study_Hours': [2, 3, 5, 7, 8, 1, 4, 6, 9, 10, 3, 5, 7, 2, 8],
    'Attendance': [60, 65, 75, 85, 90, 50, 70, 80, 95, 98, 68, 78, 88, 55, 92],
    'Result': [0, 0, 1, 1, 1, 0, 1, 1, 1, 1, 0, 1, 1, 0, 1]  # 0=Fail, 1=Pass
}

df = pd.DataFrame(data)

print("="*50)
print("STUDENT PASS/FAIL PREDICTION USING KNN")
print("="*50)
print("\nDataset:")
print(df)

# Prepare data
X = df[['Study_Hours', 'Attendance']]
y = df['Result']

# Split data
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)

# Test different k values
print("\nTesting different k values:")
for k in [1, 3, 5]:
    knn = KNeighborsClassifier(n_neighbors=k)
    knn.fit(X_train, y_train)
    accuracy = knn.score(X_test, y_test)
    print(f"k={k}: Accuracy = {accuracy * 100:.2f}%")

# Use best k=3
knn = KNeighborsClassifier(n_neighbors=3)
knn.fit(X_train, y_train)

# Predictions on test set
y_pred = knn.predict(X_test)
print(f"\nTest Predictions:")
print(f"Actual: {y_test.values}")
print(f"Predicted: {y_pred}")

# Predict for new students
print("\nNew Student Predictions:")
new_students = np.array([
    [4, 70],  # 4 hours study, 70% attendance
    [8, 90],  # 8 hours study, 90% attendance
    [2, 50]   # 2 hours study, 50% attendance
])

for student in new_students:
    prediction = knn.predict([student])
    result = "PASS" if prediction[0] == 1 else "FAIL"
    print(f"Study: {student[0]}hrs, Attendance: {student[1]}% → {result}")

# Visualization
plt.figure(figsize=(8, 6))
colors = ['red' if r == 0 else 'green' for r in df['Result']]
plt.scatter(df['Study_Hours'], df['Attendance'], c=colors, s=100, alpha=0.6)
plt.xlabel('Study Hours')
plt.ylabel('Attendance %')
plt.title('Student Performance (Red=Fail, Green=Pass)')
plt.grid(True, alpha=0.3)
plt.show()

print("\n" + "="*50)
print("Summary: KNN classifies students based on")
print("similarity to k nearest neighbors!")
print("="*50)