# K-Means Clustering in Python — README

## Aim
To understand the intuition and working of the K-means clustering algorithm and to implement it in Python (both from scratch and using scikit-learn).

---

## Requirements
- Python 3.8+
- Installed libraries:

```bash
pip install numpy matplotlib scikit-learn
```

(Optional) Use Jupyter Notebook or any IDE (VS Code, PyCharm, etc.) for interactive exploration.

---

## Theory

### What is K-means?
K-means is an **unsupervised learning** algorithm used to partition data into **K clusters** based on feature similarity. Each cluster is represented by a **centroid** (mean of points in that cluster).

### Intuition
- You choose a number of clusters **K**.
- The algorithm assigns points to the nearest centroid.
- Centroids are recalculated as the mean of all points in each cluster.
- This repeats until assignments stop changing (convergence) or a max number of iterations is reached.

### Algorithm Steps
1. **Initialize**: Randomly pick K points as initial centroids (or use methods like k-means++).
2. **Assignment step**: Assign each data point to the closest centroid (usually using Euclidean distance).
3. **Update step**: Recompute each centroid as the mean of all points assigned to it.
4. **Repeat** steps 2–3 until centroids stabilize or iterations limit is reached.

### When to use K-means
- You need to discover **groups** in data without labels (e.g., customer segmentation).
- Data has roughly **spherical clusters** with similar scale.
- You want a **fast and simple** clustering algorithm.

### Limitations
- Must choose **K** in advance (can use Elbow or Silhouette methods as guidance).
- Sensitive to **initialization** and **outliers**.
- Works best with continuous numeric features and roughly convex clusters.

---

## Implementation in Python

### 1) From-Scratch Implementation (Conceptual)
Create a file `kmeans_scratch.py`:

```python
import numpy as np

class KMeansScratch:
    def __init__(self, n_clusters=3, max_iter=100, random_state=42):
        self.n_clusters = n_clusters
        self.max_iter = max_iter
        self.random_state = random_state
        self.centroids = None

    def fit(self, X):
        rng = np.random.default_rng(self.random_state)
        # 1) Initialize centroids by sampling points
        indices = rng.choice(len(X), size=self.n_clusters, replace=False)
        self.centroids = X[indices]

        for _ in range(self.max_iter):
            # 2) Assign points to closest centroid
            distances = self._euclidean_dist(X, self.centroids)
            labels = np.argmin(distances, axis=1)

            # 3) Recompute centroids
            new_centroids = np.array([
                X[labels == k].mean(axis=0) for k in range(self.n_clusters)
            ])

            # Stop if centroids do not change
            if np.allclose(self.centroids, new_centroids):
                break
            self.centroids = new_centroids

        self.labels_ = labels

    def _euclidean_dist(self, X, centroids):
        # returns matrix [n_samples, n_clusters]
        return np.linalg.norm(X[:, None, :] - centroids[None, :, :], axis=2)
```

Usage example (in the same file or a separate script):

```python
if __name__ == "__main__":
    X = np.array([[1,1],[1.5,2],[3,4],[5,7],[3.5,5],[4.5,5],[3.5,4.5]])
    model = KMeansScratch(n_clusters=2)
    model.fit(X)
    print("Centroids:\n", model.centroids)
    print("Labels:", model.labels_)
```

This highlights the core logic: repeated assignment + mean update until convergence.

---

### 2) Using scikit-learn (Practical)

Create `kmeans_sklearn.py`:

```python
import numpy as np
from sklearn.cluster import KMeans
import matplotlib.pyplot as plt

# Sample 2D data
X = np.array([[1,1],[1.5,2],[3,4],[5,7],[3.5,5],[4.5,5],[3.5,4.5]])

# Define the model
kmeans = KMeans(n_clusters=2, n_init=10, random_state=42)

# Fit and predict
labels = kmeans.fit_predict(X)
centroids = kmeans.cluster_centers_

print("Centroids:\n", centroids)
print("Labels:", labels)

# Simple visualization
plt.scatter(X[:,0], X[:,1], c=labels)
plt.scatter(centroids[:,0], centroids[:,1], marker='x', s=200)
plt.title('K-means clustering')
plt.savefig('kmeans_clusters.png')
```

Key points in this implementation:
- `fit_predict()` runs K-means and returns cluster labels directly.
- `cluster_centers_` stores final centroids.
- `n_init` controls how many times K-means is run with different initial seeds.

---

## Choosing K (brief)
- **Elbow method**: Run K-means for different K and plot inertia (within-cluster sum of squares). Look for a "bend" in the curve.
- **Silhouette score**: Measures how similar a point is to its own cluster compared to other clusters; higher is better.
- In practice, combine **domain knowledge** + these metrics.

---

## Conclusion
K-means clustering is a foundational unsupervised algorithm that groups data by minimizing within-cluster variance. By understanding its iterative steps (assign → update → repeat) and implementing it from scratch, you see how distance and means drive clustering. Using scikit-learn then makes applying K-means to real datasets straightforward and efficient. The main responsibilities left to you are selecting K, scaling features appropriately, and validating whether clusters make sense for your problem.

---
