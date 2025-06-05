class TreeNode {
  int val;
  TreeNode? left;
  TreeNode? right;
  
  TreeNode(this.val, [this.left, this.right]);
}

class MorrisTraversal {
  /// Performs inorder traversal using Morris Traversal algorithm
  /// Time Complexity: O(n)
  /// Space Complexity: O(1)
  static List<int> inorderTraversal(TreeNode? root) {
    List<int> result = [];
    TreeNode? current = root;
    
    while (current != null) {
      // If left child is null, process current node and move to right
      if (current.left == null) {
        result.add(current.val);
        current = current.right;
      } else {
        // Find the inorder predecessor
        TreeNode? predecessor = current.left;
        while (predecessor?.right != null && predecessor?.right != current) {
          predecessor = predecessor?.right;
        }
        
        // If predecessor's right is null, make current as right child
        if (predecessor?.right == null) {
          predecessor?.right = current;
          current = current.left;
        } else {
          // If predecessor's right is current, revert the changes
          predecessor?.right = null;
          result.add(current.val);
          current = current.right;
        }
      }
    }
    
    return result;
  }
}

void main() {
  // Create a sample binary tree
  //       1
  //      / \
  //     2   3
  //    / \
  //   4   5
  TreeNode root = TreeNode(1);
  root.left = TreeNode(2);
  root.right = TreeNode(3);
  root.left?.left = TreeNode(4);
  root.left?.right = TreeNode(5);
  
  // Perform Morris Inorder Traversal
  List<int> result = MorrisTraversal.inorderTraversal(root);
  print("Inorder Traversal: $result"); // Expected output: [4, 2, 5, 1, 3]
} 