# Union-Find Practice Problem: Friend Circles

## Problem Statement
In a social network, you are given a list of friendships between people. Each friendship is represented as a pair of integers [i, j], meaning person i and person j are friends. Friendships are transitive, meaning if A is friends with B and B is friends with C, then A is friends with C.

Your task is to find the number of friend circles in the network.

### Input Format
- First line contains an integer n (1 ≤ n ≤ 1000) representing the number of people
- Following lines contain pairs of integers [i, j] representing friendships
- The input ends with an empty line

### Output Format
- A single integer representing the number of friend circles

### Example
```
Input:
5
0 1
1 2
3 4

Output:
2
```

### Explanation
- There are 5 people (0, 1, 2, 3, 4)
- Person 0 is friends with 1
- Person 1 is friends with 2
- Person 3 is friends with 4
- This forms 2 friend circles: {0,1,2} and {3,4}

### Constraints
- 1 ≤ n ≤ 1000
- 0 ≤ i, j < n
- i ≠ j

### Hints
1. Think about how to represent each person as a node in a graph
2. Consider how friendships can be represented as edges
3. Use Union-Find to efficiently merge friend circles
4. The number of friend circles is equal to the number of unique roots in the Union-Find structure

### Additional Test Cases
```dart
// Test Case 1: All people are friends
int n1 = 4;
List<List<int>> friendships1 = [
  [0, 1],
  [1, 2],
  [2, 3]
];
// Expected output: 1

// Test Case 2: No friendships
int n2 = 3;
List<List<int>> friendships2 = [];
// Expected output: 3

// Test Case 3: Complex friendship network
int n3 = 6;
List<List<int>> friendships3 = [
  [0, 1],
  [1, 2],
  [3, 4],
  [4, 5],
  [2, 3]
];
// Expected output: 1
```

### Challenge
Try to solve this problem using the Union-Find data structure. The key is to:
1. Initialize the Union-Find structure with n elements
2. Process each friendship by performing union operations
3. Count the number of unique roots at the end

### Bonus Challenge
1. Can you modify the solution to also print the members of each friend circle?
2. Can you handle the case where friendships are given as a matrix instead of a list of pairs?
3. Can you optimize the solution to handle very large networks efficiently? 