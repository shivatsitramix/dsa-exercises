# Dijkstra's Algorithm

## Introduction
Dijkstra's Algorithm is a popular algorithm for finding the shortest path between nodes in a graph. It was developed by Dutch computer scientist Edsger W. Dijkstra in 1956. The algorithm works by maintaining a set of nodes whose shortest distance from the source is known, and iteratively selecting the node with the minimum distance.

## How Dijkstra's Algorithm Works

1. Initialize distances to all nodes as infinity except the source node (set to 0)
2. Create a priority queue to store nodes and their distances
3. While the priority queue is not empty:
   - Extract the node with minimum distance
   - For each neighbor of the current node:
     - Calculate new distance = current distance + edge weight
     - If new distance < existing distance, update it
4. Continue until all nodes are processed

## Time Complexity
- Time Complexity: O((V + E) log V) where V is number of vertices and E is number of edges
- Space Complexity: O(V)

## Example Implementation in Dart

```dart
import 'dart:collection';

class Graph {
  final int vertices;
  final List<List<Map<String, dynamic>>> adjacencyList;

  Graph(this.vertices) : adjacencyList = List.generate(
    vertices,
    (_) => <Map<String, dynamic>>[],
  );

  void addEdge(int source, int destination, int weight) {
    adjacencyList[source].add({
      'destination': destination,
      'weight': weight,
    });
  }

  List<int> dijkstra(int source) {
    // Initialize distances array
    List<int> distances = List.filled(vertices, double.infinity.toInt());
    distances[source] = 0;

    // Create priority queue
    var pq = PriorityQueue<Map<String, dynamic>>(
      (a, b) => a['distance']!.compareTo(b['distance']!),
    );
    pq.add({'vertex': source, 'distance': 0});

    while (pq.isNotEmpty) {
      var current = pq.removeFirst();
      int u = current['vertex']!;

      // If we've found a shorter path, skip
      if (current['distance']! > distances[u]) continue;

      // Check all neighbors
      for (var edge in adjacencyList[u]) {
        int v = edge['destination']!;
        int weight = edge['weight']!;

        // If we found a shorter path
        if (distances[u] + weight < distances[v]) {
          distances[v] = distances[u] + weight;
          pq.add({'vertex': v, 'distance': distances[v]});
        }
      }
    }

    return distances;
  }
}

void main() {
  // Create a graph with 5 vertices
  var graph = Graph(5);

  // Add edges
  graph.addEdge(0, 1, 4);
  graph.addEdge(0, 2, 2);
  graph.addEdge(1, 2, 1);
  graph.addEdge(1, 3, 5);
  graph.addEdge(2, 3, 8);
  graph.addEdge(2, 4, 10);
  graph.addEdge(3, 4, 2);
  graph.addEdge(4, 3, 2);

  // Find shortest paths from vertex 0
  var distances = graph.dijkstra(0);

  // Print results
  for (int i = 0; i < distances.length; i++) {
    print('Shortest distance from 0 to $i: ${distances[i]}');
  }
}
```

## Practice Problem

### Problem: Network Delay Time
You are given a network of n nodes, labeled from 1 to n. You are also given times, a list of travel times as directed edges times[i] = (ui, vi, wi), where ui is the source node, vi is the target node, and wi is the time it takes for a signal to travel from source to target.

We will send a signal from a given node k. Return the minimum time it takes for all the n nodes to receive the signal. If it is impossible for all nodes to receive the signal, return -1.

```dart
class Solution {
  int networkDelayTime(List<List<int>> times, int n, int k) {
    // Create adjacency list
    List<List<Map<String, int>>> graph = List.generate(
      n + 1,
      (_) => <Map<String, int>>[],
    );

    // Build graph
    for (var time in times) {
      graph[time[0]].add({
        'destination': time[1],
        'weight': time[2],
      });
    }

    // Initialize distances
    List<int> distances = List.filled(n + 1, double.infinity.toInt());
    distances[k] = 0;

    // Priority queue
    var pq = PriorityQueue<Map<String, int>>(
      (a, b) => a['distance']!.compareTo(b['distance']!),
    );
    pq.add({'vertex': k, 'distance': 0});

    while (pq.isNotEmpty) {
      var current = pq.removeFirst();
      int u = current['vertex']!;

      if (current['distance']! > distances[u]) continue;

      for (var edge in graph[u]) {
        int v = edge['destination']!;
        int weight = edge['weight']!;

        if (distances[u] + weight < distances[v]) {
          distances[v] = distances[u] + weight;
          pq.add({'vertex': v, 'distance': distances[v]});
        }
      }
    }

    // Find maximum distance
    int maxDistance = 0;
    for (int i = 1; i <= n; i++) {
      if (distances[i] == double.infinity.toInt()) return -1;
      maxDistance = maxDistance > distances[i] ? maxDistance : distances[i];
    }

    return maxDistance;
  }
}

void main() {
  var solution = Solution();
  
  // Test case
  var times = [
    [2, 1, 1],
    [2, 3, 1],
    [3, 4, 1]
  ];
  int n = 4;
  int k = 2;

  print(solution.networkDelayTime(times, n, k)); // Expected output: 2
}
```

## Explanation of the Practice Problem
In this problem, we need to find the minimum time it takes for a signal to reach all nodes in a network. We use Dijkstra's algorithm to find the shortest path from the source node to all other nodes. The answer is the maximum distance among all shortest paths, as this represents the time needed for the signal to reach the farthest node.

The solution:
1. Creates an adjacency list representation of the graph
2. Uses Dijkstra's algorithm to find shortest paths
3. Returns the maximum distance if all nodes are reachable, or -1 if some nodes are unreachable

This problem is a great way to practice implementing Dijkstra's algorithm in a real-world scenario. 

# Dijkstra's Algorithm: Step-by-Step Conditioning

## Prerequisites
Before implementing Dijkstra's Algorithm, we need to ensure:
1. The graph must be weighted (each edge has a non-negative weight)
2. The graph can be directed or undirected
3. We need a source node to start from
4. We need a way to track distances and visited nodes

## Step-by-Step Conditioning

### 1. Initialization Phase
```dart
// Initialize distances array with infinity
List<int> distances = List.filled(vertices, double.infinity.toInt());
// Set source node distance to 0
distances[source] = 0;

// Create priority queue for efficient node selection
var pq = PriorityQueue<Map<String, dynamic>>(
  (a, b) => a['distance']!.compareTo(b['distance']!),
);
// Add source node to priority queue
pq.add({'vertex': source, 'distance': 0});
```

### 2. Main Algorithm Loop
The algorithm continues while there are nodes to process:
```dart
while (pq.isNotEmpty) {
  // Get node with minimum distance
  var current = pq.removeFirst();
  int u = current['vertex']!;

  // Skip if we've found a better path
  if (current['distance']! > distances[u]) continue;

  // Process neighbors
  for (var edge in adjacencyList[u]) {
    // ... neighbor processing
  }
}
```

### 3. Neighbor Processing Conditions
For each neighbor, we check three conditions:
```dart
for (var edge in adjacencyList[u]) {
  int v = edge['destination']!;
  int weight = edge['weight']!;

  // Condition 1: Check if new path is shorter
  if (distances[u] + weight < distances[v]) {
    // Condition 2: Update distance if shorter path found
    distances[v] = distances[u] + weight;
    // Condition 3: Add to priority queue for processing
    pq.add({'vertex': v, 'distance': distances[v]});
  }
}
```

## Key Conditions and Their Purposes

### 1. Distance Update Condition
```dart
if (distances[u] + weight < distances[v])
```
- Purpose: Ensures we only update distances when we find a shorter path
- Why: Maintains the optimality of the algorithm
- Example: If current path to v is 10, and new path through u is 7, we update

### 2. Priority Queue Skip Condition
```dart
if (current['distance']! > distances[u]) continue;
```
- Purpose: Avoids processing nodes with outdated distances
- Why: Improves efficiency by skipping redundant updates
- Example: If we've already found a better path to u, skip processing

### 3. Initialization Conditions
```dart
distances[source] = 0;  // Source node
distances[i] = infinity;  // All other nodes
```
- Purpose: Sets up correct initial state
- Why: Ensures algorithm starts from known state
- Example: Source node starts at 0, all others at infinity

## Example with Visual Steps

Let's walk through a simple example:

```
Graph:
    1
   / \
  2   3
   \ /
    4
```

### Step 1: Initialization
- Set all distances to infinity
- Set source (node 1) distance to 0
- Priority Queue: [(1, 0)]

### Step 2: First Iteration
- Process node 1
- Update distances to nodes 2 and 3
- Priority Queue: [(2, 2), (3, 1)]

### Step 3: Second Iteration
- Process node 3 (smallest distance)
- Update distance to node 4
- Priority Queue: [(2, 2), (4, 3)]

### Step 4: Final Iteration
- Process remaining nodes
- All distances are now optimal

## Common Edge Cases and Conditions

### 1. Disconnected Nodes
```dart
// Check if any node is unreachable
for (int i = 0; i < distances.length; i++) {
  if (distances[i] == double.infinity.toInt()) {
    // Node is unreachable
  }
}
```

### 2. Negative Weights
```dart
// Check for negative weights
if (weight < 0) {
  throw Exception("Dijkstra's algorithm doesn't work with negative weights");
}
```

### 3. Self-Loops
```dart
// Handle self-loops if needed
if (u == v) {
  // Skip or handle self-loop
  continue;
}
```

## Implementation Tips

1. **Priority Queue Selection**
   - Use a min-heap based priority queue
   - Ensure efficient O(log n) operations

2. **Distance Updates**
   - Always check if new path is shorter
   - Update both distance and priority queue

3. **Termination Conditions**
   - Stop when priority queue is empty
   - All shortest paths have been found

4. **Memory Management**
   - Clear priority queue after use
   - Reset distances for multiple runs

## Time Complexity Analysis

The time complexity is determined by these conditions:
1. Priority Queue Operations: O(log V)
2. Edge Processing: O(E)
3. Total Complexity: O((V + E) log V)

Where:
- V = number of vertices
- E = number of edges 