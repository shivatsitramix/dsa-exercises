# Depth-First Search (DFS) in Dart

## What is DFS?
Depth-First Search (DFS) is a graph traversal algorithm that explores as far as possible along each branch before backtracking. It's like exploring a maze by always taking the first path you see and only turning back when you hit a dead end.

## Key Characteristics
- Uses a stack (either explicitly or through recursion)
- Visits nodes in depth-first order
- Memory efficient compared to BFS for deep trees
- Can be implemented recursively or iteratively

## Implementation Approaches

### 1. Recursive DFS
```dart
class Graph {
  Map<int, List<int>> adjacencyList = {};

  void addEdge(int vertex, int neighbor) {
    if (!adjacencyList.containsKey(vertex)) {
      adjacencyList[vertex] = [];
    }
    adjacencyList[vertex]!.add(neighbor);
  }

  void dfsRecursive(int startVertex) {
    Set<int> visited = {};
    _dfsHelper(startVertex, visited);
  }

  void _dfsHelper(int vertex, Set<int> visited) {
    visited.add(vertex);
    print('Visited: $vertex');

    for (var neighbor in adjacencyList[vertex] ?? []) {
      if (!visited.contains(neighbor)) {
        _dfsHelper(neighbor, visited);
      }
    }
  }
}
```

### 2. Iterative DFS
```dart
void dfsIterative(int startVertex) {
  Set<int> visited = {};
  List<int> stack = [startVertex];

  while (stack.isNotEmpty) {
    int vertex = stack.removeLast();
    
    if (!visited.contains(vertex)) {
      visited.add(vertex);
      print('Visited: $vertex');
      
      // Add unvisited neighbors to stack
      for (var neighbor in adjacencyList[vertex] ?? []) {
        if (!visited.contains(neighbor)) {
          stack.add(neighbor);
        }
      }
    }
  }
}
```

## Example Usage
```dart
void main() {
  var graph = Graph();
  
  // Create a sample graph
  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(1, 3);
  graph.addEdge(2, 4);
  graph.addEdge(3, 5);
  
  print('DFS Recursive Traversal:');
  graph.dfsRecursive(0);
}
```

## Practice Problem: Find Path in Maze

### Problem Statement
Given a 2D maze represented as a grid where:
- 0 represents a wall
- 1 represents a path
- 2 represents the start
- 3 represents the end

Find if there exists a path from start to end using DFS.

### Solution
```dart
class MazeSolver {
  List<List<int>> maze;
  int rows;
  int cols;
  
  MazeSolver(this.maze) {
    rows = maze.length;
    cols = maze[0].length;
  }
  
  bool findPath() {
    // Find start position
    int startX = 0, startY = 0;
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (maze[i][j] == 2) {
          startX = i;
          startY = j;
          break;
        }
      }
    }
    
    return _dfs(startX, startY);
  }
  
  bool _dfs(int x, int y) {
    // Check boundaries and walls
    if (x < 0 || x >= rows || y < 0 || y >= cols || maze[x][y] == 0) {
      return false;
    }
    
    // Found the end
    if (maze[x][y] == 3) {
      return true;
    }
    
    // Mark as visited
    maze[x][y] = 0;
    
    // Try all four directions
    return _dfs(x + 1, y) || // down
           _dfs(x - 1, y) || // up
           _dfs(x, y + 1) || // right
           _dfs(x, y - 1);   // left
  }
}

// Example usage
void main() {
  List<List<int>> maze = [
    [1, 1, 1, 1],
    [0, 0, 1, 0],
    [2, 1, 1, 3],
    [0, 0, 1, 0]
  ];
  
  var solver = MazeSolver(maze);
  print('Path exists: ${solver.findPath()}');
}
```

## Time and Space Complexity
- Time Complexity: O(V + E) where V is the number of vertices and E is the number of edges
- Space Complexity: O(V) for the visited set and recursion stack

## Common Applications
1. Maze solving
2. Topological sorting
3. Cycle detection in graphs
4. Finding strongly connected components
5. Solving puzzles like Sudoku

## Practice Exercise
Try modifying the maze solver to:
1. Print the actual path from start to end
2. Find the shortest path using DFS (hint: you'll need to track the path length)
3. Handle multiple possible paths and find all solutions

Remember: While DFS is great for exploring paths, it doesn't guarantee the shortest path. For finding the shortest path, Breadth-First Search (BFS) is often more appropriate. 