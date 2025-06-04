int maxSubArraySum(List<int> nums) {
  int maxSoFar = nums[0];
  int currMax = nums[0];

  int start = 0;
  int tempStart = 0;
  int end = 0;

  for (int i = 1; i < nums.length; i++) {
    if (nums[i] > currMax + nums[i]) {
      currMax = nums[i];
      tempStart = i; 
    } else {
      currMax = currMax + nums[i];
    }

    if (currMax > maxSoFar) {
      maxSoFar = currMax;
      start = tempStart;
      end = i;
    }
  }

  List<int> maxSubArray = nums.sublist(start, end + 1);
  print("Max Subarray: $maxSubArray");

  return maxSoFar;
}

void main() {
  List<int> arr = [-2, 1, -3, 4, -1, 2, 1, -5, 4];
  print("Max Subarray Sum is: ${maxSubArraySum(arr)}");
}
