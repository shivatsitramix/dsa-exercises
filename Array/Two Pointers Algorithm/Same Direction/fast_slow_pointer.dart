void moveZeroes(List<int> nums) {
  int slow = 0;

  for (int fast = 0; fast < nums.length; fast++) {
    if (nums[fast] != 0) {
      int temp = nums[slow];
      nums[slow] = nums[fast];
      nums[fast] = temp;
      slow++;
    }
  }
}

void main() {
  List<int> nums = [1, 1, 0, 0, 12];
  moveZeroes(nums);
  print(nums); // Output: [1, 3, 12, 0, 0]
}
