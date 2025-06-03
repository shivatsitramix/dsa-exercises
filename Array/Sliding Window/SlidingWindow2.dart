


int lengthOfLongestSubstring(String s) {
  int start = 0;
  int maxLength = 0;
  Map<String, int> seen = {};

  for (int end = 0; end < s.length; end++) {
    String char = s[end];

    // If character already seen, move `start` to after its last position
    if (seen.containsKey(char) && seen[char]! >= start) {
      start = seen[char]! + 1;
    }

    seen[char] = end;

    int windowSize = end - start + 1;
    maxLength = maxLength > windowSize ? maxLength : windowSize;
  }

  return maxLength;
}

void main() {
  String s = "abcabcbb";
  print(lengthOfLongestSubstring(s)); // Output: 3
}
