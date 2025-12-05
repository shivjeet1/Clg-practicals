import numpy as np
import pandas as pd
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

# Student data: Study Hours, Test Score
np.random.seed(42)

# Create 3 groups of students
group1 = np.random.randn(15, 2) * [1, 5] + [2, 45]   # Low performers
group2 = np.random.randn(15, 2) * [1, 5] + [5, 70]   # Average performers
group3 = np.random.randn(15, 2) * [1, 5] + [8, 90]   # High performers

X = np.vstack([group1, group2, group3])

print("Student Performance Data")
print(f"Total students: {len(X)}")
print(f"Features: Study Hours, Test Score")

# Apply K-Means clustering
kmeans = KMeans(n_clusters=3, random_state=42)
kmeans.fit(X)

labels = kmeans.labels_
centers = kmeans.cluster_centers_

print("\nStudents per Performance Group:")
for i in range(3):
    count = np.sum(labels == i)
    avg_hours = X[labels == i][:, 0].mean()
    avg_score = X[labels == i][:, 1].mean()
    print(f"Group {i}: {count} students | Avg Hours: {avg_hours:.1f} | Avg Score: {avg_score:.1f}")

# Visualize
plt.figure(figsize=(10, 6))
colors = ['red', 'green', 'blue']
names = ['Low Performers', 'Average Performers', 'High Performers']

for i in range(3):
    cluster_data = X[labels == i]
    plt.scatter(cluster_data[:, 0], cluster_data[:, 1], 
                c=colors[i], label=names[i], s=100, alpha=0.6)

# Plot centers
plt.scatter(centers[:, 0], centers[:, 1], c='black', s=400, 
            marker='D', label='Group Centers', edgecolors='yellow', linewidths=3)

plt.xlabel('Study Hours per Day')
plt.ylabel('Test Score (%)')
plt.title('Student Performance Clustering')
plt.legend()
plt.grid(True, alpha=0.3)
plt.show()

# Predict new student
new_student = [[6, 75]]  # 6 hours study, 75% score
prediction = kmeans.predict(new_student)
print(f"\nNew Student (6 hrs, 75%): Belongs to {names[prediction[0]]}")