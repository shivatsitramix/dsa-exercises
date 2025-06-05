# Morris Inorder Traversal in Dart

## Overview

Morris Inorder Traversal is a binary tree traversal algorithm that visits nodes **inorder** without using recursion or a stack. It modifies the tree temporarily by creating “threads” (links) to inorder successors, achieving **O(1) space complexity** while restoring the tree after traversal.

---

## How Morris Inorder Traversal Works

* Start at the root node.
* For each node:

  * If the node has no left child, process it and move to its right child.
  * If the node has a left child, find its inorder predecessor (rightmost node in the left subtree).

    * If the predecessor’s right pointer is `null`, create a thread by pointing it to the current node and move to the left child.
    * If the predecessor’s right pointer points to the current node (thread exists), remove the thread, process the current node, and move to the right child.

This temporarily modifies the tree but restores it to original form after traversal.

---

## Algorithm Complexity

* **Time:** O(n) — Each node is visited at most twice.
* **Space:** O(1) — No additional stack or recursion is used.

---

## Example Tree

```
       1
      / \
     2   3
    / \
   4   5
```

Traversal Order: `[4, 2, 5, 1, 3]`

---

## Advantages

* Space efficient (no extra memory).
* Simple stack/recursion-free traversal.
* Tree structure is restored post-traversal.

---

## Disadvantages

* Temporarily modifies the tree.
* Slightly complex to implement.
* Not ideal if tree concurrent access occurs during traversal.

---

## Usage Example (Dart)

```dart
class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  TreeNode(this.val, {this.left, this.right});
}

List<int> morrisInorderTraversal(TreeNode? root) {
  List<int> result = [];
  TreeNode? current = root;

  while (current != null) {
    if (current.left == null) {
      result.add(current.val);
      current = current.right;
    } else {
      // Find the inorder predecessor of current
      TreeNode? predecessor = current.left;
      while (predecessor!.right != null && predecessor.right != current) {
        predecessor = predecessor.right;
      }

      if (predecessor.right == null) {
        // Make current the right child of predecessor
        predecessor.right = current;
        current = current.left;
      } else {
        // Revert changes and process current
        predecessor.right = null;
        result.add(current.val);
        current = current.right;
      }
    }
  }
  return result;
}

void main() {
  var root = TreeNode(1,
      left: TreeNode(2, left: TreeNode(4), right: TreeNode(5)),
      right: TreeNode(3));

  var inorder = morrisInorderTraversal(root);
  print(inorder); // Output: [4, 2, 5, 1, 3]
}
```
