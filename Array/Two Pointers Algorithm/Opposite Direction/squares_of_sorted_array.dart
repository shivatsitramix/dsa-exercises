
class Solution {
  List<int> sortedSquares(List<int> nums) {
    int n = nums.length;
    List<int> result = List.filled(n, 0);
    int left = 0;
    int right = n - 1;
    int index = n - 1;

    while (left <= right) {
      int leftSquare = nums[left] * nums[left];
      int rightSquare = nums[right] * nums[right];

      if (leftSquare > rightSquare) {
        result[index] = leftSquare;
        left++;
      } else {
        result[index] = rightSquare;
        right--;
      }
      index--;
    }

    return result;
  }
}

void main() {
  Solution solution = Solution();
  
  // Test case 1
  List<int> nums1 = [-4, -1, 0, 3, 10];
  print('Input: $nums1');
  print('Output: ${solution.sortedSquares(nums1)}'); // Expected: [0, 1, 9, 16, 100]
  
  // Test case 2
  List<int> nums2 = [-7, -3, 2, 3, 11];
  print('\nInput: $nums2');
  print('Output: ${solution.sortedSquares(nums2)}'); // Expected: [4, 9, 9, 49, 121]
} 