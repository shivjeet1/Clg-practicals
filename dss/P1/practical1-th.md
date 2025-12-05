# Python Essential Libraries

## Aim
Provide a compact, practical overview of essential Python libraries (10–12) across data science, machine learning, web, and general-purpose tasks — with aim, quick requirements, brief theory and a minimal example for each.

## Requirements
- Python 3.8+ (recommended 3.9/3.10)
- pip (or conda)
- Install command (all at once):

```bash
pip install numpy pandas matplotlib seaborn scikit-learn tensorflow requests beautifulsoup4 flask sqlalchemy pillow pytest
```

---

## Libraries (short, precise — max ~10 lines per library)

### 1) NumPy
**Aim:** Efficient numerical arrays and linear algebra foundations.
**Theory & usage:** Provides `ndarray`, vectorized operations, broadcasting and fast C-backed math. Used as base for scientific computing.
**Minimal example:**
```python
import numpy as np
a = np.array([1,2,3])
print(a.mean(), a + 5)
```
**Notes:** Use for numerical kernels, random sampling, and as base for other libraries.

---

### 2) pandas
**Aim:** Tabular data structures and data manipulation (DataFrame/Series).
**Theory & usage:** High-level data I/O (CSV, Excel, SQL), grouping, joins, reshaping and time-series utilities.
**Minimal example:**
```python
import pandas as pd
df = pd.DataFrame({'x':[1,2], 'y':[3,4]})
print(df.describe())
```
**Notes:** Great first step for data cleaning before ML.

---

### 3) matplotlib
**Aim:** Core plotting library for static visualizations.
**Theory & usage:** Low-level API to create figures, axes, and common plot types. Build custom plots and export images.
**Minimal example:**
```python
import matplotlib.pyplot as plt
plt.plot([1,2,3], [4,5,6])
plt.title('Line')
plt.savefig('line.png')
```
**Notes:** Combine with pandas plotting for convenience.

---

### 4) seaborn
**Aim:** Statistical data visualization built on matplotlib.
**Theory & usage:** High-level functions for attractive default styles: distributions, categorical plots, heatmaps, and pairplots.
**Minimal example:**
```python
import seaborn as sns
tips = sns.load_dataset('tips')
sns.boxplot(x='day', y='total_bill', data=tips)
```
**Notes:** Use for quick EDA and beautiful defaults.

---

### 5) scikit-learn
**Aim:** General-purpose machine learning (classical ML).
**Theory & usage:** Implements pipelines, preprocessing, supervised & unsupervised algorithms, model selection and evaluation.
**Minimal example:**
```python
from sklearn.linear_model import LogisticRegression
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y)
clf = LogisticRegression().fit(X_train, y_train)
print(clf.score(X_test, y_test))
```
**Notes:** Ideal for prototyping and classical ML tasks.

---

### 6) TensorFlow
**Aim:** Deep learning framework for model building and training (also Keras API).
**Theory & usage:** Build computational graphs (eager by default), layers, optimizers and exportable models.
**Minimal example:**
```python
import tensorflow as tf
model = tf.keras.Sequential([tf.keras.layers.Dense(1, input_shape=(3,))])
model.compile('adam','mse')
```
**Notes:** Use for scalable training; PyTorch is an alternative with dynamic graph feel.

---

### 7) requests
**Aim:** Simple HTTP requests for interacting with web APIs.
**Theory & usage:** Send GET/POST, handle headers, params, JSON and sessions.
**Minimal example:**
```python
import requests
r = requests.get('https://api.github.com')
print(r.status_code, r.json())
```
**Notes:** Use for data ingestion from REST endpoints.

---

### 8) BeautifulSoup (bs4)
**Aim:** Parse and extract data from HTML/XML.
**Theory & usage:** Create a parse tree from markup, use selectors or traversal to extract content.
**Minimal example:**
```python
from bs4 import BeautifulSoup
soup = BeautifulSoup('<p>Hello</p>', 'html.parser')
print(soup.p.text)
```
**Notes:** Pair with `requests` for scraping static pages (obey robots.txt & terms).

---

### 9) Flask
**Aim:** Lightweight web framework for building APIs and web apps.
**Theory & usage:** Minimal routing, request handling, templating (Jinja2), and easy extensibility.
**Minimal example:**
```python
from flask import Flask
app = Flask(__name__)
@app.route('/')
def index():
    return 'OK'
```
**Notes:** Good for quick prototypes and microservices.

---

### 10) SQLAlchemy
**Aim:** Python SQL toolkit and ORM for database access.
**Theory & usage:** Declarative models, sessions, query construction and cross-db portability.
**Minimal example:**
```python
from sqlalchemy import create_engine, text
engine = create_engine('sqlite:///:memory:')
with engine.connect() as c:
    c.execute(text('SELECT 1'))
```
**Notes:** Use ORM for domain models or core SQL for complex queries.

---

### 11) Pillow (PIL)
**Aim:** Image processing: open, transform, and save images.
**Theory & usage:** Read/write many formats, resize, crop, draw text and basic filters.
**Minimal example:**
```python
from PIL import Image
img = Image.open('in.jpg')
img = img.resize((200,200))
img.save('out.jpg')
```
**Notes:** Useful for preprocessing images before ML or web serving.

---

### 12) pytest
**Aim:** Testing framework for writing unit and integration tests.
**Theory & usage:** Simple test functions, fixtures, parametrize and rich plugins.
**Minimal example:**
```python
# test_sum.py
def test_sum():
    assert sum([1,2,3]) == 6
```
**Notes:** Run `pytest` to discover and run tests.

---

## Conclusion
This README provides a compact reference to quickly understand purposes, minimal examples and when to choose each library. Each entry is intentionally short for quick onboarding and documentation.

---

