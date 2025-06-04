int quickSelect(List<int> nums, int k) {
  int left = 0;
  int right = nums.length - 1;
  k = k - 1;

  while (left <= right) {
    int pivotIndex = _partition(nums, left, right);

    if (pivotIndex == k) {
      return nums[pivotIndex];
    } else if (pivotIndex < k) {
      left = pivotIndex + 1;
    } else {
      right = pivotIndex - 1;
    }
  }

  return -1;
}

int _partition(List<int> nums, int left, int right) {
  int pivot = nums[right];
  int i = left;

  for (int j = left; j < right; j++) {
    if (nums[j] < pivot) {
      int temp = nums[i];
      nums[i] = nums[j];
      nums[j] = temp;
      i++;
    }
  }

  int temp = nums[i];
  nums[i] = nums[right];
  nums[right] = temp;

  return i;
}

void main() {
  List<int> arr = [25, 16, 44, 32, 20, 15];
  int k = 4;

  int result = quickSelect(arr, k);
  print('The $k-th smallest element is: $result');
}
