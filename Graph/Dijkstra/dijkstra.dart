import 'package:collection/collection.dart';
import 'dart:math';

class Solution {
  static const int INF = 1000000000; // Large number to represent "infinity"

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
    List<int> distances = List.filled(n + 1, INF);
    distances[k] = 0;

    // Priority queue
    final pq = PriorityQueue<Map<String, int>>(
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

    // Find the maximum distance
    int maxDistance = 0;
    for (int i = 1; i <= n; i++) {
      if (distances[i] == INF) return -1;
      maxDistance = max(maxDistance, distances[i]);
    }

    return maxDistance;
  }
}

void main() {
  var solution = Solution();

  var times = [
    [2, 1, 1],
    [2, 3, 1],
    [3, 4, 1]
  ];
  int n = 4;
  int k = 2;

  print(solution.networkDelayTime(times, n, k)); // Output: 2
}
