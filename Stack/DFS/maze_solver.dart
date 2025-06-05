class MazeSolver {
  List<List<int>> maze;
  late int rows;
  late int cols;

  MazeSolver(this.maze) {
    rows = maze.length;
    cols = maze[0].length;
  }

  // Finds path and returns list of coordinates [(x,y), ...]
  List<List<int>>? findPath() {
    int startX = 0, startY = 0;

    // Find start position (value 2)
    for (int i = 0; i < rows; i++) {
      for (int j = 0; j < cols; j++) {
        if (maze[i][j] == 2) {
          startX = i;
          startY = j;
          break;
        }
      }
    }

    List<List<int>> path = [];
    if (_dfs(startX, startY, path)) {
      return path;
    }
    return null; // no path found
  }

  // DFS returns true if path found, path updated with coordinates
  bool _dfs(int x, int y, List<List<int>> path) {
    // Boundary and wall check
    if (x < 0 || x >= rows || y < 0 || y >= cols || maze[x][y] == 0) {
      return false;
    }

    // Found the end (3)
    if (maze[x][y] == 3) {
      path.add([x, y]);
      return true;
    }

    // Mark current cell as visited by setting to 0
    int temp = maze[x][y];
    maze[x][y] = 0;

    // Add current position to path
    path.add([x, y]);

    // Explore neighbors: down, up, right, left
    if (_dfs(x + 1, y, path) ||
        _dfs(x - 1, y, path) ||
        _dfs(x, y + 1, path) ||
        _dfs(x, y - 1, path)) {
      return true;
    }

    // Backtrack: remove current position from path and restore maze cell
    path.removeLast();
    maze[x][y] = temp;

    return false;
  }
}

void main() {
  List<List<int>> maze = [
    [1, 1, 1, 1],
    [0, 0, 1, 0],
    [2, 1, 1, 3],
    [0, 0, 1, 0]
  ];

  var solver = MazeSolver(maze);
  var path = solver.findPath();

  if (path != null) {
    print('Path found:');
    for (var pos in path) {
      print('(${pos[0]}, ${pos[1]})');
    }
  } else {
    print('No path exists.');
  }
}
