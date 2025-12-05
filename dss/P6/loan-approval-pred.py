# Import libraries
import pandas as pd
from sklearn.tree import DecisionTreeClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score, confusion_matrix

# Create sample loan dataset
data = {
    'Age': [25, 35, 45, 23, 30, 40, 50, 28, 33, 38, 42, 27, 31, 36, 44],
    'Income': [30000, 50000, 80000, 25000, 45000, 70000, 90000, 35000, 
               48000, 65000, 75000, 32000, 47000, 60000, 82000],
    'CreditScore': [600, 700, 750, 580, 680, 720, 780, 650, 690, 710, 
                    740, 620, 685, 705, 760],
    'Approved': [0, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1, 0, 1, 1, 1]  # 0=No, 1=Yes
}

df = pd.DataFrame(data)
print("Loan Application Data:")
print(df.head(10))

# Prepare data
X = df[['Age', 'Income', 'CreditScore']]
y = df['Approved']

# Split data
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.3, random_state=42
)

# Create and train model
model = DecisionTreeClassifier(max_depth=3, random_state=42)
model.fit(X_train, y_train)

# Predictions
y_pred = model.predict(X_test)

# Evaluate
accuracy = accuracy_score(y_test, y_pred)
print(f"\nModel Accuracy: {accuracy * 100:.2f}%")

# Confusion matrix
cm = confusion_matrix(y_test, y_pred)
print(f"\nConfusion Matrix:")
print(f"  True Negatives: {cm[0][0]}, False Positives: {cm[0][1]}")
print(f"  False Negatives: {cm[1][0]}, True Positives: {cm[1][1]}")

# Predict for new applicants
new_applicants = [
    [30, 45000, 680],  # Age 30, Income 45k, Credit 680
    [50, 85000, 760]   # Age 50, Income 85k, Credit 760
]

predictions = model.predict(new_applicants)
print("\nNew Applicant Predictions:")
for i, pred in enumerate(predictions):
    result = "Approved" if pred == 1 else "Rejected"
    print(f"  Applicant {i+1}: {result}")