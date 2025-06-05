import 'dart:collection';

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

void main() {
  // Example 1: Simple DAG
  print('Example 1: Simple DAG');
  Graph graph1 = Graph(6);
  graph1.addEdge(5, 2);
  graph1.addEdge(5, 0);
  graph1.addEdge(4, 0);
  graph1.addEdge(4, 1);
  graph1.addEdge(2, 3);
  graph1.addEdge(3, 1);

  try {
    List<int> result1 = graph1.topologicalSort();
    print('Topological Sort: $result1');
  } catch (e) {
    print('Error: $e');
  }

  // Example 2: Graph with cycle
  print('\nExample 2: Graph with cycle');
  Graph graph2 = Graph(3);
  graph2.addEdge(0, 1);
  graph2.addEdge(1, 2);
  graph2.addEdge(2, 0); // Creates a cycle

  try {
    List<int> result2 = graph2.topologicalSort();
    print('Topological Sort: $result2');
  } catch (e) {
    print('Error: $e');
  }

  // Example 3: Course Prerequisites
  print('\nExample 3: Course Prerequisites');
  Graph courseGraph = Graph(5);
  // Course 0: Introduction to Programming
  // Course 1: Data Structures
  // Course 2: Algorithms
  // Course 3: Database Systems
  // Course 4: Web Development
  courseGraph.addEdge(0, 1); // Intro to Programming is prerequisite for Data Structures
  courseGraph.addEdge(1, 2); // Data Structures is prerequisite for Algorithms
  courseGraph.addEdge(0, 3); // Intro to Programming is prerequisite for Database Systems
  courseGraph.addEdge(0, 4); // Intro to Programming is prerequisite for Web Development

  try {
    List<int> courseOrder = courseGraph.topologicalSort();
    print('Course Order: $courseOrder');
    print('Interpretation:');
    print('0: Introduction to Programming');
    print('1: Data Structures');
    print('2: Algorithms');
    print('3: Database Systems');
    print('4: Web Development');
  } catch (e) {
    print('Error: $e');
  }
} 