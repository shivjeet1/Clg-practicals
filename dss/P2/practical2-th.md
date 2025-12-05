# Python Fundamentals

## Aim
To understand and implement fundamental Python programming elements including variables, data types, standard data structures, basic operations, and control flow.

## Requirements
- Python 3.8+ (recommended 3.9/3.10)
- Any text editor or IDE (VS Code, PyCharm, etc.)
- Run code via terminal: `python file.py`

---

## 1. Variables & Data Types
**Concept:** Variables store values. Python has dynamic typing, so no explicit type declaration.
**Types:** `int`, `float`, `str`, `bool`, `NoneType`.
**Example:**
```python
x = 10
name = "Alice"
is_valid = True
```
**Note:** Type inferred at runtime.

---

## 2. Data Structures
Python provides built‑in collections for storing data.

### Lists
- Ordered, mutable sequences.
```python
nums = [1, 2, 3]
nums.append(4)
```

### Tuples
- Ordered, immutable sequences.
```python
t = (1, 2, 3)
```

### Dictionaries
- Key‑value mapping.
```python
user = {"name":"Bob", "age":23}
```

### Sets
- Unordered, unique elements.
```python
s = {1, 2, 3}
```

### Range
- Immutable sequence for iteration.
```python
r = range(5)  # 0..4
```

---

## 3. Operations
### Arithmetic
`+ - * / % // **`
```python
result = (5 + 3) * 2
```

### Logical
`and`, `or`, `not`
```python
if is_valid and x > 5:
    print("OK")
```

---

## 4. Control Flow
### Conditional
```python
if x > 10:
    print("Large")
elif x == 10:
    print("Equal")
else:
    print("Small")
```

### Loops
**For Loop:**
```python
for i in range(3):
    print(i)
```

**While Loop:**
```python
while x > 0:
    x -= 1
```

---

## Conclusion
This document provides a concise overview of Python fundamentals: variable creation, core data types, built‑in data structures, basic operations, and essential control flow structures, with minimal examples for fast understanding.

## Checklist
- [x] Single markdown file
- [x] Short and precise
- [x] Covers variables, types, data structures, operations, control flow
- [x] Examples included
- [x] Ready for documentation and IDE use

