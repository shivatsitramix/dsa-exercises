int kmpSearch(String text, String pattern) {
  if (pattern.isEmpty) return 0;

  List<int> lps = _buildLPS(pattern);
  int i = 0;
  int j = 0;

  while (i < text.length) {
    if (text[i] == pattern[j]) {
      i++;
      j++;
      if (j == pattern.length) return i - j;
    } else {
      if (j != 0) {
        j = lps[j - 1];
      } else {
        i++;
      }
    }
  }

  return -1;
}

List<int> _buildLPS(String pattern) {
  List<int> lps = List.filled(pattern.length, 0);
  int len = 0;
  int i = 1;

  while (i < pattern.length) {
    if (pattern[i] == pattern[len]) {
      len++;
      lps[i] = len;
      i++;
    } else {
      if (len != 0) {
        len = lps[len - 1];
      } else {
        lps[i] = 0;
        i++;
      }
    }
  }

  print('LPS Array: $lps');
  return lps;
}

void main() {
  String text = "abxabcabcaby";
  String pattern = "abcaby";

  int index = kmpSearch(text, pattern);
  print('Pattern found at index: $index');
}
