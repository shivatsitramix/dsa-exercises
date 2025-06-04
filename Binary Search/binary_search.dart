int binarySearch(List<int> nums, int target) {
  int left = 0;
  int right = nums.length - 1;

  while (left <= right) {
    int mid = left + ((right - left) ~/ 2); 

    if (nums[mid] == target) {
      return mid; 
    }

    if (nums[mid] < target) {
      left = mid + 1;
    }
    else {
      right = mid - 1;
    }
  }

  return -1;
}

void main() {
  List<int> nums = [1, 2, 3, 4, 5];
  int target = 3;
  print("Index of $target is ${binarySearch(nums, target)}");
}
