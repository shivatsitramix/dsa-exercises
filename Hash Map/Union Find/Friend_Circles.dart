class UnionFind {
  List<int> parent;
  List<int> rank;

  UnionFind(int n)
      : parent = List<int>.generate(n, (i) => i),
        rank = List<int>.filled(n, 0);

  int find(int x) {
    if (parent[x] != x) {
      parent[x] = find(parent[x]); // Path compression
    }
    return parent[x];
  }

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

int findFriendCircles(int n, List<List<int>> friendships) {
  UnionFind uf = UnionFind(n);

  for (List<int> pair in friendships) {
    uf.union(pair[0], pair[1]);
  }

  // Count unique roots
  Set<int> uniqueRoots = {};
  for (int i = 0; i < n; i++) {
    uniqueRoots.add(uf.find(i));
  }

  return uniqueRoots.length;
}

void main() {
  int n = 5;
  List<List<int>> friendships = [
    [0, 1],
    [1, 2],
    [3, 4]
  ];

  print(findFriendCircles(n, friendships)); // Output: 2
}
