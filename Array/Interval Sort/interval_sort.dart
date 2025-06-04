List<List<int>> mergeIntervals(List<List<int>> intervals) {
  if (intervals.length <= 1) return intervals;

  intervals.sort((a, b) => a[0].compareTo(b[0]));

  List<List<int>> merged = [intervals[0]];

  for (int i = 1; i < intervals.length; i++) {
    List<int> last = merged.last;
    List<int> current = intervals[i];

    if (current[0] <= last[1]) {
      last[1] = last[1] > current[1] ? last[1] : current[1];
    } else {
      merged.add(current);
    }
  }

  return merged;
}

void main() {
  List<List<int>> input = [
    [1, 3],
    [2, 6],
    [8, 10],
    [15, 18]
  ];

  List<List<int>> result = mergeIntervals(input);

  print(result); // Output: [[1, 6], [8, 10], [15, 18]]
}
