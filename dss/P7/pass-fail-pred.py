# Import libraries
from sklearn.svm import SVC
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import numpy as np
import matplotlib.pyplot as plt

print("="*50)
print("STUDENT PASS/FAIL PREDICTION USING SVM")
print("="*50)

# Student data: [Study Hours, Previous Score] -> Pass(1)/Fail(0)
X = np.array([
    [2, 45], [3, 55], [1, 40], [4, 60],
    [5, 65], [2, 50], [6, 70], [7, 75],
    [3, 52], [8, 80], [4, 58], [9, 85],
    [1, 35], [5, 68], [6, 72], [7, 78],
    [2, 48], [8, 82], [3, 54], [9, 88]
])

y = np.array([0, 0, 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1])

print("\nDataset Info:")
print(f"Total students: {len(X)}")
print(f"Passed: {sum(y)}")
print(f"Failed: {len(y) - sum(y)}")
print(f"\nSample data (Study Hours, Previous Score):")
for i in range(3):
    status = "Pass" if y[i] == 1 else "Fail"
    print(f"  {X[i]} -> {status}")

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.25, random_state=42
)

# Train SVM with linear kernel
model = SVC(kernel='linear', random_state=42)

print("\nTraining model...")
model.fit(X_train, y_train)
print("Training completed!")

# Predictions
y_pred = model.predict(X_test)

# Accuracy
accuracy = accuracy_score(y_test, y_pred)
print(f"\nModel Accuracy: {accuracy*100:.2f}%")

# Test predictions
print("\nTest Results:")
for i in range(len(X_test)):
    actual = "Pass" if y_test[i] == 1 else "Fail"
    predicted = "Pass" if y_pred[i] == 1 else "Fail"
    match = "✓" if y_test[i] == y_pred[i] else "✗"
    print(f"{match} Study: {X_test[i][0]}h, Score: {X_test[i][1]} -> "
          f"Predicted: {predicted}, Actual: {actual}")

# Predict for new students
print("\nNew Student Predictions:")
new_students = [
    [4, 62],
    [2, 40],
    [7, 80]
]

for student in new_students:
    prediction = model.predict([student])
    result = "PASS" if prediction[0] == 1 else "FAIL"
    print(f"Study Hours: {student[0]}, Previous Score: {student[1]} -> {result}")

# Simple visualization
plt.figure(figsize=(8, 6))
plt.scatter(X[y==0][:, 0], X[y==0][:, 1], color='red', label='Fail', alpha=0.6)
plt.scatter(X[y==1][:, 0], X[y==1][:, 1], color='green', label='Pass', alpha=0.6)
plt.xlabel('Study Hours')
plt.ylabel('Previous Score')
plt.title('Student Pass/Fail Classification')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()

print("\n✓ Visualization displayed!")