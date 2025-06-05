# Union-Find (Disjoint Set) Data Structure

## Introduction
Union-Find, also known as Disjoint Set, is a data structure that keeps track of elements which are split into one or more disjoint sets. It provides efficient operations to:
- Find which set an element belongs to
- Union two sets together

## Key Operations
1. **Find**: Determines which subset a particular element is in
2. **Union**: Joins two subsets into a single subset

## Implementation in Dart

```dart
class UnionFind {
  List<int> parent;
  List<int> rank;

  UnionFind(int n) {
    parent = List<int>.generate(n, (i) => i);
    rank = List<int>.filled(n, 0);
  }

  // Find the root of the set containing element x
  int find(int x) {
    if (parent[x] != x) {
      // Path compression
      parent[x] = find(parent[x]);
    }
    return parent[x];
  }

  // Union two sets
  void union(int x, int y) {
    int rootX = find(x);
    int rootY = find(y);

    if (rootX == rootY) return;

    // Union by rank
    if (rank[rootX] < rank[rootY]) {
      parent[rootX] = rootY;
    } else if (rank[rootX] > rank[rootY]) {
      parent[rootY] = rootX;
    } else {
      parent[rootY] = rootX;
      rank[rootX]++;
    }
  }
}
```

## Example Usage

```dart
void main() {
  // Create a Union-Find structure with 5 elements
  var uf = UnionFind(5);
  
  // Initially, each element is in its own set
  // 0, 1, 2, 3, 4 are separate sets
  
  // Union sets containing 0 and 1
  uf.union(0, 1);
  // Now sets are: {0,1}, {2}, {3}, {4}
  
  // Union sets containing 2 and 3
  uf.union(2, 3);
  // Now sets are: {0,1}, {2,3}, {4}
  
  // Check if 0 and 1 are in the same set
  print(uf.find(0) == uf.find(1)); // true
  
  // Check if 1 and 2 are in the same set
  print(uf.find(1) == uf.find(2)); // false
}
```

## Practice Problem: Number of Connected Components

### Problem Statement
Given an undirected graph with n nodes, find the number of connected components in the graph.

### Solution

```dart
int countComponents(int n, List<List<int>> edges) {
  var uf = UnionFind(n);
  
  // Union all edges
  for (var edge in edges) {
    uf.union(edge[0], edge[1]);
  }
  
  // Count unique roots
  Set<int> uniqueRoots = {};
  for (int i = 0; i < n; i++) {
    uniqueRoots.add(uf.find(i));
  }
  
  return uniqueRoots.length;
}

void main() {
  // Example usage
  int n = 5;
  List<List<int>> edges = [
    [0, 1],
    [1, 2],
    [3, 4]
  ];
  
  print(countComponents(n, edges)); // Output: 2
  // Explanation: The graph has 2 connected components:
  // {0,1,2} and {3,4}
}
```

## Time Complexity
- Find operation: O(α(n)) amortized time, where α is the inverse Ackermann function
- Union operation: O(α(n)) amortized time
- Space complexity: O(n)

## Applications
1. Kruskal's algorithm for Minimum Spanning Tree
2. Image processing
3. Network connectivity
4. Game theory
5. Social network analysis

## Key Optimizations
1. **Path Compression**: Makes the find operation more efficient by flattening the structure
2. **Union by Rank**: Keeps the tree balanced by always attaching the smaller tree to the root of the larger tree 