List<int> findAnagrams(String s, String p) {
  int sLen = s.length;
  int pLen = p.length;
  if (sLen < pLen) return [];

  List<int> result = [];

  // Frequency map for p and for current window in s
  List<int> pCount = List.filled(26, 0);
  List<int> sCount = List.filled(26, 0);

  // Fill pCount
  for (int i = 0; i < pLen; i++) {
    pCount[p.codeUnitAt(i) - 'a'.codeUnitAt(0)]++;
    sCount[s.codeUnitAt(i) - 'a'.codeUnitAt(0)]++;
  }

  if (_areEqual(pCount, sCount)) result.add(0);

  for (int i = pLen; i < sLen; i++) {
    // Slide the window: remove left, add right
    sCount[s.codeUnitAt(i) - 'a'.codeUnitAt(0)]++;
    sCount[s.codeUnitAt(i - pLen) - 'a'.codeUnitAt(0)]--;

    if (_areEqual(pCount, sCount)) {
      result.add(i - pLen + 1);
    }
  }

  return result;
}

bool _areEqual(List<int> a, List<int> b) {
  for (int i = 0; i < 26; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

void main() {
  String s = "cbaebabacd";
  String p = "abc";
  print(findAnagrams(s, p)); // Output: [0, 6]
}
