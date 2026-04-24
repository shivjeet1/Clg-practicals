# Practical 1: Quick Sort

## Aim
To implement and analyze the Quick Sort algorithm.

## Requirements
* GCC Compiler / C IDE
* Text Editor

## Theory
* [cite_start]Quick Sort is a divide-and-conquer sorting algorithm[cite: 2].
* [cite_start]Choose a pivot element from the array[cite: 3].
* [cite_start]Partition the array so that: [cite: 4]
  * [cite_start]Elements smaller than the pivot are placed on the left side[cite: 5].
  * [cite_start]Elements greater than the pivot are placed on the right side[cite: 6].
* [cite_start]Recursively apply Quick Sort to the left and right subarrays[cite: 7].
* [cite_start]Time complexity O(n log n)[cite: 8].

## Procedure
1. Initialize the array and define the low and high indices.
2. Call the partition function to select a pivot and rearrange the elements.
3. Recursively call the quick sort function on the sub-arrays partitioned by the pivot.
4. Output the sorted array and the metric counts (comparisons, recursive calls).

## Algorithm
```c
void quickSort(int arr[], int low, int high) {
    if(low < high) {
        recursiveCalls++;
        int pi = partition(arr, low, high);
        quickSort(arr, low, pi - 1);
        quickSort(arr, pi + 1, high);
    }
}
```

## Diagrams
*(Draw an array partitioning diagram showing the pivot separating smaller and larger elements).*

## Conclusion
Quick Sort was successfully implemented and its performance was analyzed using a divide-and-conquer approach.

---

# Practical 2: Power Function (Divide and Conquer)

## Aim
To compute a large positive integer power using the Divide and Conquer technique.

## Requirements
* GCC Compiler / C IDE
* Text Editor

## Theory
* [cite_start]The Divide and Conquer technique solves a problem by dividing it into smaller subproblems, solving them recursively, and combining the results[cite: 64].
* [cite_start]For computing large positive integer power, the traditional approach multiplies the base repeatedly[cite: 65].
* [cite_start]Time complexity: O(log n)[cite: 66].

## Procedure
1. Input the base and the exponent.
2. If the exponent is 0, return 1.
3. Recursively calculate the power of the base to half the exponent.
4. If the exponent is even, multiply the half-result by itself. If odd, multiply the base by the half-result squared.

## Algorithm
```c
long long power(long long a, int n) {
    if(n == 0) return 1;
    long long half = power(a, n / 2);
    if(n % 2 == 0) {
        multiplications++;
        return half * half;
    } else {
        multiplications += 2;
        return a * half * half;
    }
}
```

## Diagrams
*(Draw a recursive recursion tree showing the halving of the exponent at each step).*

## Conclusion
The exponentiation function was effectively optimized using the divide-and-conquer strategy, reducing the time complexity significantly.

---

# Practical 3: Merge Sort

## Aim
To implement and analyze the Merge Sort algorithm.

## Requirements
* GCC Compiler / C IDE
* Text Editor

## Theory
* [cite_start]Merge Sort repeatedly divides the array until each subarray contains only one element[cite: 101]. 
* [cite_start]A single-element array is already sorted[cite: 101].
* [cite_start]Time complexity: O(nlogn)[cite: 102].

## Procedure
1. Calculate the mid-point of the array to divide it into two halves.
2. Recursively call Merge Sort for the first half and the second half.
3. Merge the two sorted halves back into a single sorted array.
4. Output the final sorted array.

## Algorithm
```c
void mergeSort(int arr[], int l, int r) {
    if(l < r) {
        int m = (l + r) / 2;
        mergeSort(arr, l, m);
        mergeSort(arr, m + 1, r);
        merge(arr, l, m, r);
    }
}
```

## Diagrams
*(Draw a tree diagram illustrating the top-down splitting of the array and bottom-up merging).*

## Conclusion
Merge sort was successfully implemented, demonstrating stable sorting with a consistent logarithmic time complexity.

---

# Practical 4: Fractional Knapsack

## Aim
To solve the Fractional Knapsack optimization problem using a Greedy approach.

## Requirements
* GCC Compiler / C IDE
* Text Editor

## Theory
* [cite_start]The Fractional Knapsack problem is an optimization problem where we maximize profit while staying within the knapsack capacity[cite: 156].
* [cite_start]Time complexity O(nlogn)[cite: 157].

## Procedure
1. Define a structure to hold item weight, profit, and the calculated profit-to-weight ratio.
2. Sort all items in descending order based on their profit-to-weight ratio.
3. Iterate through the sorted items, adding full items to the knapsack if capacity allows.
4. If an item exceeds remaining capacity, take a fractional part of it to fill the knapsack and break the loop.

## Algorithm
```c
void sort(struct Item items[], int n) {
    for(int i = 0; i < n - 1; i++) {
        for(int j = i + 1; j < n; j++) {
            if(items[i].ratio < items[j].ratio) {
                struct Item temp = items[i];
                items[i] = items[j];
                items[j] = temp;
            }
        }
    }
}
```

## Diagrams
*(Draw a table showing items sorted by profit/weight ratio and the step-by-step filling of the knapsack capacity).*

## Conclusion
The greedy strategy successfully maximized the total profit for the given knapsack capacity by prioritizing items with the highest value-to-weight ratios.

---

# Practical 5: Minimum Spanning Tree (MST)

## Aim
To find the Minimum Spanning Tree of a given graph using Prim’s and Kruskal’s algorithms.

## Requirements
* GCC Compiler / C IDE
* Text Editor

## Theory
* [cite_start]A Minimum Spanning Tree (MST) of a connected, undirected weighted graph is a subset of edges that: [cite: 213, 214]
  * [cite_start]Connects all vertices[cite: 215].
  * [cite_start]Has no cycles[cite: 216].
  * [cite_start]Has minimum possible total edge weight[cite: 217].
* [cite_start]Greedy algorithms are commonly used to find MST[cite: 218].

## Procedure
**Prim's Approach:** Initialize visited array. Find the minimum weight adjacent edge from the visited set to the unvisited set. Add the vertex to the visited set. Repeat until all vertices are included.
**Kruskal's Approach:** Sort all edges by weight. Pick the smallest edge. If it doesn't form a cycle (using Union-Find), include it in the MST. Repeat until (V-1) edges are selected.

## Algorithm
```c
int find(int i) {
    while(parent[i])
        i = parent[i];
    return i;
}

int uni(int i, int j) {
    if(i != j) {
        parent[j] = i;
        return 1;
    }
    return 0;
}
```

## Diagrams
*(Draw an initial weighted graph and the resulting tree highlighting the minimum cost edges).*

## Conclusion
Both greedy methodologies successfully identified the subset of edges forming the Minimum Spanning Tree without cycles.

---

# Practical 6: Traveling Salesman Problem (TSP)

## Aim
To solve the Traveling Salesman Problem using Dynamic Programming and Bitmasking.

## Requirements
* GCC Compiler / C IDE
* Text Editor

## Theory
* [cite_start]The Traveling Salesman Problem (TSP) is a classic optimization problem in which a salesman must visit each city exactly once and return to the starting city while minimizing the total travel cost[cite: 339, 340].

## Procedure
1. Represent the visited cities using a bitmask.
2. If all cities are visited (mask equals `(1 << n) - 1`), return the cost from the current city back to the starting city.
3. For the current city, check all unvisited cities.
4. Recursively calculate the cost to visit the next city and update the minimum answer using a memoization table (DP).

## Algorithm
```c
int tsp(int mask, int pos) {
    if (mask == (1 << n) - 1)
        return cost[pos][0];
    if (dp[mask][pos] != -1)
        return dp[mask][pos];
    int ans = INF;
    for(int city = 0; city < n; city++) {
        if ((mask & (1 << city)) == 0) {
            int newAns = cost[pos][city] + tsp(mask | (1 << city), city);
            ans = min(ans, newAns);
        }
    }
    return dp[mask][pos] = ans;
}
```

## Diagrams
*(Draw a complete graph with nodes as cities and edges as travel costs, alongside a DP state transition table).*

## Conclusion
Dynamic programming successfully minimized the total travel cost by systematically exploring routes and memoizing overlapping subproblems.

---

# Practical 7: N-Queens Problem

## Aim
To solve the N-Queens problem using the Backtracking technique.

## Requirements
* GCC Compiler / C IDE
* Text Editor

## Theory
* [cite_start]Backtracking is a problem-solving technique that builds solutions step by step and removes those solutions that fail to satisfy the given constraints[cite: 390].

## Procedure
1. Attempt to place a queen row by row.
2. For each column in the current row, check if the position is safe (no conflicts diagonally or vertically).
3. If safe, place the queen and recursively attempt to place the next queen in the next row.
4. If a dead-end is reached, backtrack by removing the queen and trying the next column.

## Algorithm
```c
int place(int k, int i) {
    for(int j = 1; j < k; j++) {
        if(x[j] == i || abs(x[j] - i) == abs(j - k)) {
            return 0;
        }
    }
    return 1;
}

void nQueens(int k) {
    for(int i = 1; i <= n; i++) {
        if(place(k, i)) {
            x[k] = i;
            if(k == n) {
                // Base case handling
            } else {
                nQueens(k + 1);
            }
        }
    }
}
```

## Diagrams
*(Draw an NxN chessboard diagram demonstrating a safe state and a backtracking state).*

## Conclusion
The backtracking algorithm successfully explored the state space tree, placing N queens on the board without mutual attacks.

---

# Practical 8: 0/1 Knapsack Problem

## Aim
To solve the 0/1 Knapsack problem using Dynamic Programming.

## Requirements
* GCC Compiler / C IDE
* Text Editor

## Theory
* [cite_start]The 0/1 Knapsack problem is a classic optimization problem where we must select items to maximize total profit without exceeding the knapsack capacity[cite: 439].
* [cite_start]Time complexity O(nw)[cite: 440].

## Procedure
1. Create a DP table with dimensions based on the number of items and maximum capacity.
2. Initialize the first row and column with 0.
3. Iterate through items and capacities. If the current item's weight is less than or equal to the current capacity, take the maximum of including or excluding the item.
4. If the item exceeds current capacity, carry forward the value from the previous row.

## Algorithm
```c
for(int i = 0; i <= n; i++) {
    for(int w = 0; w <= W; w++) {
        if(i == 0 || w == 0)
            dp[i][w] = 0;
        else if(weight[i] <= w)
            dp[i][w] = max(dp[i-1][w], profit[i] + dp[i-1][w-weight[i]]);
        else
            dp[i][w] = dp[i-1][w];
    }
}
```

## Diagrams
*(Draw the 2D DP table showing the progressive calculation of max profit for given weights).*

## Conclusion
Dynamic programming provided an optimal solution to the 0/1 Knapsack problem by utilizing a tabulation approach to evaluate all combinations efficiently.


