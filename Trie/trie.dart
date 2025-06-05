class TrieNode {
  // Map to store child nodes, where key is the character
  final Map<String, TrieNode> children = {};
  // Flag to mark the end of a word
  bool isEndOfWord = false;
}

class Trie {
  final TrieNode root = TrieNode();

  /// Inserts a word into the trie
  void insert(String word) {
    TrieNode current = root;
    
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      // If the character doesn't exist in children, create a new node
      if (!current.children.containsKey(char)) {
        current.children[char] = TrieNode();
      }
      // Move to the child node
      current = current.children[char]!;
    }
    // Mark the end of the word
    current.isEndOfWord = true;
  }

  /// Returns true if the word exists in the trie
  bool search(String word) {
    TrieNode? node = _searchNode(word);
    // Return true if the word exists and is marked as end of word
    return node != null && node.isEndOfWord;
  }

  /// Returns true if there is any word that starts with the given prefix
  bool startsWith(String prefix) {
    TrieNode? node = _searchNode(prefix);
    // Return true if the prefix exists (node is not null)
    return node != null;
  }

  /// Helper method to search for a node
  TrieNode? _searchNode(String word) {
    TrieNode current = root;
    
    for (int i = 0; i < word.length; i++) {
      String char = word[i];
      // If the character doesn't exist, return null
      if (!current.children.containsKey(char)) {
        return null;
      }
      // Move to the child node
      current = current.children[char]!;
    }
    return current;
  }
}

// Example usage
void main() {
  Trie trie = Trie();
  
  // Insert words
  trie.insert("apple");
  trie.insert("app");
  trie.insert("application");
  trie.insert("banana");
  
  // Test search
  print("Search 'apple': ${trie.search("apple")}");     // true
  print("Search 'app': ${trie.search("app")}");         // true
  print("Search 'appl': ${trie.search("appl")}");       // false
  
  // Test prefix search
  print("StartsWith 'app': ${trie.startsWith("app")}"); // true
  print("StartsWith 'ban': ${trie.startsWith("ban")}"); // true
  print("StartsWith 'cat': ${trie.startsWith("cat")}"); // false
} 