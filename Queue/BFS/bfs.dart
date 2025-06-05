import 'dart:collection';

class Graph {
  Map<int, List<int>> adjacencyList = {};

  void addEdge(int u, int v) {
    adjacencyList.putIfAbsent(u, () => []).add(v);
    adjacencyList.putIfAbsent(v, () => []).add(u); // assuming undirected graph
  }

  List<int>? shortestPath(int start, int end) {
    if (start == end) return [start];

    Set<int> visited = {start};
    Queue<int> queue = Queue();
    Map<int, int> parent = {}; // to reconstruct path

    queue.add(start);

    while (queue.isNotEmpty) {
      int current = queue.removeFirst();

      for (int neighbor in adjacencyList[current] ?? []) {
        if (!visited.contains(neighbor)) {
          visited.add(neighbor);
          parent[neighbor] = current;
          queue.add(neighbor);

          if (neighbor == end) {
            // reconstruct path
            List<int> path = [];
            int node = end;
            while (node != start) {
              path.add(node);
              node = parent[node]!;
            }
            path.add(start);
            return path.reversed.toList();
          }
        }
      }
    }

    return null; // no path found
  }
}

void main() {
  var graph = Graph();

  // Build sample graph
  graph.addEdge(0, 1);
  graph.addEdge(0, 2);
  graph.addEdge(1, 3);
  graph.addEdge(2, 4);
  graph.addEdge(3, 5);
  graph.addEdge(4, 5);

  int source = 0;
  int destination = 5;

  var path = graph.shortestPath(source, destination);

  if (path != null) {
    print('Shortest path from $source to $destination: $path');
  } else {
    print('No path found from $source to $destination');
  }
}
