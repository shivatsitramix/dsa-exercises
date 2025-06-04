Of course. Let's dive into the theory behind Binary Search and then apply it to a classic problem.

### Binary Search: The Theory

Binary Search is a highly efficient algorithm for finding a specific value within a **sorted** array. Its core principle is to repeatedly divide the search interval in half. If the value of the search key is less than the item in the middle of the interval, it narrows the search to the lower half. Otherwise, it narrows the search to the upper half. This process continues until the value is found or the interval is empty.

#### Prerequisites

The single most crucial prerequisite for Binary Search is that the **data structure must be sorted**. If the array is not sorted, the algorithm will not work correctly as it relies on the ordered nature of the data to make its decisions.

#### How It Works

1.  **Initialization**:
    * Start with three pointers: `low` (pointing to the first index of the array, `0`), `high` (pointing to the last index of the array, `n-1`), and `mid`.

2.  **Iteration**:
    * Enter a loop that continues as long as `low` is less than or equal to `high`.
    * Calculate the middle index: `mid = low + (high - low) / 2`. This method of calculating the middle index is preferred over `(low + high) / 2` to prevent potential integer overflow if `low` and `high` are very large.
    * **Compare** the element at the `mid` index with the target value:
        * **Case 1: Match Found** - If `array[mid]` is equal to the target, the search is successful, and the index `mid` is returned.
        * **Case 2: Target is Smaller** - If the target value is less than `array[mid]`, it means the target, if it exists, must be in the left half of the current interval. So, we update `high` to `mid - 1`.
        * **Case 3: Target is Larger** - If the target value is greater than `array[mid]`, it means the target, if it exists, must be in the right half of the current interval. So, we update `low` to `mid + 1`.

3.  **Termination**:
    * If the loop finishes (i.e., `low` becomes greater than `high`), it means the target value is not present in the array. In this case, a special value, typically `-1`, is returned.

#### Complexity

* **Time Complexity**: $O(\log n)$. With each step, the search interval is halved. This logarithmic time complexity makes Binary Search extremely fast for large datasets compared to a linear search ($O(n)$).
* **Space Complexity**: $O(1)$ for the iterative approach, as it only uses a few variables to keep track of the indices.

---

### Binary Search: The Problem

#### Problem Statement

You are given a sorted array of integers and a target integer. Your task is to write a function that searches for the target in the array. If the target exists, return its index. Otherwise, return -1.

**Example:**

* **Array**: `[2, 5, 8, 12, 16, 23, 38, 56, 72, 91]`
* **Target**: `23`
* **Expected Output**: `5` (since `23` is at index 5)

#### Solution with Step-by-Step Walkthrough

Let's apply the Binary Search algorithm to the example above.

**Array**: `[2, 5, 8, 12, 16, 23, 38, 56, 72, 91]`
**Target**: `23`

**Initial State:**
* `low = 0`
* `high = 9` (the last index)

**Iteration 1:**
1.  Calculate `mid`: `mid = 0 + (9 - 0) / 2 = 4`.
2.  Compare `array[mid]` (which is `array[4] = 16`) with the `target` (23).
3.  Since `16 < 23`, the target must be in the right half.
4.  Update `low`: `low = mid + 1 = 5`.
    * New Search Space: `[23, 38, 56, 72, 91]`
    * `low` is now `5`, `high` is still `9`.

**Iteration 2:**
1.  Calculate `mid`: `mid = 5 + (9 - 5) / 2 = 5 + 2 = 7`.
2.  Compare `array[mid]` (which is `array[7] = 56`) with the `target` (23).
3.  Since `56 > 23`, the target must be in the left half of this new space.
4.  Update `high`: `high = mid - 1 = 6`.
    * New Search Space: `[23, 38]`
    * `low` is now `5`, `high` is now `6`.

**Iteration 3:**
1.  Calculate `mid`: `mid = 5 + (6 - 5) / 2 = 5 + 0 = 5`.
2.  Compare `array[mid]` (which is `array[5] = 23`) with the `target` (23).
3.  The values match! `23 == 23`.
4.  **Return the index `mid`**, which is `5`.

The function terminates and returns `5`, which is the correct index of the target value. If the target had been, for example, `24`, the loop would have continued until `low` became greater than `high`, at which point it would return `-1`.