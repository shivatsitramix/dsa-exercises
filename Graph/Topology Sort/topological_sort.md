# Topological Sort

## Introduction
Topological Sort is a linear ordering of vertices in a directed acyclic graph (DAG) where for every directed edge (u, v), vertex u comes before vertex v in the ordering. This ordering is particularly useful in scenarios where we need to determine the order of tasks or dependencies.

## Key Concepts

1. **Directed Acyclic Graph (DAG)**
   - A directed graph with no cycles
   - Each edge has a direction
   - No path exists that starts and ends at the same vertex

2. **In-degree**
   - Number of incoming edges to a vertex
   - Vertices with in-degree 0 are good starting points

3. **Topological Order**
   - A valid sequence where all dependencies are satisfied
   - Not unique - multiple valid orderings may exist

## Applications

1. Task Scheduling
2. Build Systems
3. Course Prerequisites
4. Package Dependencies
5. Event Scheduling

## Algorithm Steps

1. Calculate in-degree for all vertices
2. Add all vertices with in-degree 0 to a queue
3. While queue is not empty:
   - Remove a vertex from queue
   - Add it to result
   - Decrease in-degree of all adjacent vertices
   - If in-degree becomes 0, add to queue
4. If result size equals number of vertices, return result
   - Otherwise, graph has a cycle

## Dart Implementation

```dart
class Graph {
  final int vertices;
  final List<List<int>> adjacencyList;

  Graph(this.vertices) : adjacencyList = List.generate(vertices, (_) => []);

  void addEdge(int from, int to) {
    adjacencyList[from].add(to);
  }

  List<int> topologicalSort() {
    // Calculate in-degree for all vertices
    List<int> inDegree = List.filled(vertices, 0);
    for (var edges in adjacencyList) {
      for (var vertex in edges) {
        inDegree[vertex]++;
      }
    }

    // Queue for vertices with in-degree 0
    Queue<int> queue = Queue<int>();
    for (int i = 0; i < vertices; i++) {
      if (inDegree[i] == 0) {
        queue.add(i);
      }
    }

    // Result list
    List<int> result = [];
    int count = 0;

    // Process vertices
    while (queue.isNotEmpty) {
      int current = queue.removeFirst();
      result.add(current);
      count++;

      // Decrease in-degree for adjacent vertices
      for (var adjacent in adjacencyList[current]) {
        inDegree[adjacent]--;
        if (inDegree[adjacent] == 0) {
          queue.add(adjacent);
        }
      }
    }

    // Check if topological sort is possible
    if (count != vertices) {
      throw Exception('Graph contains a cycle');
    }

    return result;
  }
}

// Example usage
void main() {
  // Create a graph with 6 vertices
  Graph graph = Graph(6);

  // Add edges (representing dependencies)
  graph.addEdge(5, 2);
  graph.addEdge(5, 0);
  graph.addEdge(4, 0);
  graph.addEdge(4, 1);
  graph.addEdge(2, 3);
  graph.addEdge(3, 1);

  try {
    List<int> result = graph.topologicalSort();
    print('Topological Sort: $result');
  } catch (e) {
    print('Error: $e');
  }
}
```

## Example Explanation

Let's break down the example graph:

```
5 → 2 → 3 → 1
↓   ↓
0 ← 4
```

In this graph:
- Vertex 5 has no incoming edges (in-degree = 0)
- Vertex 4 has no incoming edges (in-degree = 0)
- Other vertices have incoming edges

The topological sort will produce one of these valid orderings:
- [4, 5, 0, 2, 3, 1]
- [5, 4, 0, 2, 3, 1]

## Time and Space Complexity

- Time Complexity: O(V + E)
  - V = number of vertices
  - E = number of edges
- Space Complexity: O(V)
  - For storing in-degree array and queue

## Common Use Cases

1. **Course Prerequisites**
   - Vertices represent courses
   - Edges represent prerequisites
   - Topological sort gives valid course sequence

2. **Build Systems**
   - Vertices represent tasks
   - Edges represent dependencies
   - Topological sort determines build order

3. **Package Dependencies**
   - Vertices represent packages
   - Edges represent dependencies
   - Topological sort gives installation order

## Handling Cycles

If the graph contains a cycle, topological sort is impossible. The implementation above detects cycles by checking if the result size equals the number of vertices. If not, it means some vertices couldn't be processed due to a cycle.

## Best Practices

1. Always validate input graph is a DAG
2. Handle cycles appropriately
3. Consider using a priority queue for specific ordering requirements
4. Cache results if the graph doesn't change frequently
5. Use appropriate data structures for large graphs 