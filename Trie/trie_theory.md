# Trie Data Structure: Theory and Implementation

## What is a Trie?
A Trie (pronounced "try") is a tree-like data structure used to store and retrieve strings. The name comes from the word "retrieval." It's particularly efficient for operations involving strings and is commonly used in:
- Autocomplete features
- Spell checkers
- IP routing tables
- Dictionary implementations

## Structure of a Trie
- Each node in a Trie represents a character
- The root node is empty
- Each path from root to leaf represents a complete word
- Nodes can have multiple children (one for each possible character)
- A special flag is used to mark the end of a word

## Key Operations

### 1. Insertion
- Start from the root node
- For each character in the word:
  - If the character exists as a child, move to that node
  - If not, create a new node for that character
- Mark the last node as the end of the word

### 2. Search
- Start from the root node
- For each character in the word:
  - If the character exists as a child, move to that node
  - If not, return false (word doesn't exist)
- Check if the last node is marked as the end of a word

### 3. Prefix Search
- Similar to search but doesn't require the last node to be marked as end of word
- Returns true if the prefix exists in the Trie

## Time Complexity
- Insertion: O(m) where m is the length of the word
- Search: O(m) where m is the length of the word
- Space Complexity: O(ALPHABET_SIZE * N * M) where:
  - ALPHABET_SIZE is the number of possible characters
  - N is the number of words
  - M is the average length of words

## Example
Let's see how a Trie stores the words: "cat", "car", "dog", "do"

```
        root
       /    \
      c      d
      |      |
      a      o
     / \     |
    t   r    g
```

- To store "cat": root → c → a → t
- To store "car": root → c → a → r
- To store "dog": root → d → o → g
- To store "do": root → d → o

## Common Applications
1. **Autocomplete**: Quickly find all words with a given prefix
2. **Spell Checker**: Efficiently check if a word exists in a dictionary
3. **IP Routing**: Longest prefix matching in routing tables
4. **Contact List**: Fast contact name searches
5. **Word Games**: Efficient word validation in games like Scrabble

## Advantages
- Fast prefix-based operations
- Space efficient for common prefixes
- Predictable performance
- No hash collisions

## Disadvantages
- More space required compared to hash tables
- Not as efficient for exact string matching as hash tables
- Slower than hash tables for non-string data

## Problem Statement
Implement a Trie data structure that supports the following operations:
1. `insert(word)`: Inserts a word into the Trie
2. `search(word)`: Returns true if the word exists in the Trie
3. `startsWith(prefix)`: Returns true if there is any word that starts with the given prefix

Example:
```
Trie trie = new Trie();
trie.insert("apple");
trie.search("apple");   // returns true
trie.search("app");     // returns false
trie.startsWith("app"); // returns true
trie.insert("app");   
trie.search("app");     // returns true
``` 