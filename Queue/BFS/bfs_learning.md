# Breadth-First Search (BFS) in Dart

## What is BFS?
Breadth-First Search (BFS) is a graph traversal algorithm that explores all vertices at the present depth before moving on to vertices at the next depth level. It's particularly useful for:
- Finding the shortest path between two vertices
- Level-order traversal of trees
- Finding all vertices within one connected component
- Testing if a graph is bipartite

## Key Characteristics
1. Uses a Queue data structure
2. Visits all nodes at the current depth before moving deeper
3. Guarantees the shortest path in unweighted graphs
4. Time Complexity: O(V + E) where V is vertices and E is edges
5. Space Complexity: O(V) for the queue

## Basic BFS Implementation in Dart

```dart
import 'dart:collection';

class Graph {
  Map<int, List<int>> adjacencyList = {};

  void addEdge(int vertex, int neighbor) {
    if (!adjacencyList.containsKey(vertex)) {
      adjacencyList[vertex] = [];
    }
    adjacencyList[vertex]!.add(neighbor);
  }

  List<int> bfs(int startVertex) {
    List<int> visited = [];
    Queue<int> queue = Queue<int>();
    
    visited.add(startVertex);
    queue.add(startVertex);

    while (queue.isNotEmpty) {
      int currentVertex = queue.removeFirst();
      
      if (adjacencyList.containsKey(currentVertex)) {
        for (int neighbor in adjacencyList[currentVertex]!) {
          if (!visited.contains(neighbor)) {
            visited.add(neighbor);
            queue.add(neighbor);
          }
        }
      }
    }
    
    return visited;
  }
}
```

## Example Usage

```dart
void main() {
  Graph graph = Graph();
  
  // Create a sample graph
  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(1, 3);
  graph.addEdge(2, 3);
  graph.addEdge(2, 4);
  graph.addEdge(3, 4);
  
  // Perform BFS starting from vertex 0
  List<int> traversal = graph.bfs(0);
  print('BFS Traversal: $traversal'); // Output: [0, 1, 2, 3, 4]
}
```

## Practice Problem: Level Order Traversal of Binary Tree

### Problem Statement
Implement a function to perform level order traversal of a binary tree. The function should return a list of lists, where each inner list contains the nodes at that level.

### Solution

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  
  TreeNode(this.val, [this.left, this.right]);
}

List<List<int>> levelOrderTraversal(TreeNode? root) {
  if (root == null) return [];
  
  List<List<int>> result = [];
  Queue<TreeNode> queue = Queue<TreeNode>();
  queue.add(root);
  
  while (queue.isNotEmpty) {
    int levelSize = queue.length;
    List<int> currentLevel = [];
    
    for (int i = 0; i < levelSize; i++) {
      TreeNode currentNode = queue.removeFirst();
      currentLevel.add(currentNode.val);
      
      if (currentNode.left != null) {
        queue.add(currentNode.left!);
      }
      if (currentNode.right != null) {
        queue.add(currentNode.right!);
      }
    }
    
    result.add(currentLevel);
  }
  
  return result;
}
```

### Example Usage

```dart
void main() {
  // Create a sample binary tree
  //       3
  //      / \
  //     9  20
  //        / \
  //       15  7
  
  TreeNode root = TreeNode(3,
    TreeNode(9),
    TreeNode(20,
      TreeNode(15),
      TreeNode(7)
    )
  );
  
  List<List<int>> levels = levelOrderTraversal(root);
  print('Level Order Traversal: $levels');
  // Output: [[3], [9, 20], [15, 7]]
}
```

## Key Takeaways
1. BFS is implemented using a Queue data structure
2. It's particularly useful for finding shortest paths in unweighted graphs
3. The algorithm visits all nodes at the current level before moving to the next level
4. BFS has applications in:
   - Web crawling
   - Social networking (finding connections)
   - GPS navigation systems
   - Peer-to-peer networks
   - Broadcasting in network

## Practice Exercise
Try implementing a function that finds the shortest path between two nodes in an unweighted graph using BFS. The function should return the path as a list of nodes from source to destination. 