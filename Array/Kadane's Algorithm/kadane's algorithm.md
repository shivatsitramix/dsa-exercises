Kadane's algorithm is a dynamic programming approach to efficiently find the maximum sum of a contiguous subarray within a one-dimensional array of numbers. It's a simple yet powerful algorithm that solves this classic problem in linear time, making it highly efficient.

### Problem Statement

Given an array of integers, find the contiguous subarray (containing at least one number) that has the largest sum and return that sum.

A **contiguous subarray** is a sequence of adjacent elements in the array. For instance, in the array `[1, 2, 3, 4]`, `[2, 3]` is a contiguous subarray, but `[1, 3]` is not.

---

### The Algorithm

Kadane's algorithm works by iterating through the array while keeping track of two key variables:

* `current_max`: The maximum sum of a subarray ending at the current position.
* `global_max`: The maximum sum found so far across the entire array.

Here's the step-by-step process:

1.  **Initialization**:
    * Initialize `current_max` and `global_max` to the first element of the array.

2.  **Iteration**:
    * Iterate through the array starting from the second element.
    * For each element, update `current_max` by choosing the larger of two options:
        * The current element itself.
        * The sum of the `current_max` and the current element.
    * This step essentially decides whether to extend the previous subarray or to start a new subarray from the current element.
    * After updating `current_max`, compare it with `global_max`. If `current_max` is greater, update `global_max`.

3.  **Result**:
    * After the loop finishes, `global_max` will hold the maximum subarray sum.

---

### Example

Let's walk through an example with the array: `[-2, 1, -3, 4, -1, 2, 1, -5, 4]`

| Current Element | `current_max` Calculation | `current_max` | `global_max` | Subarray for `global_max` |
| :--- | :--- | :--- | :--- | :--- |
| **-2** | (Initialization) | -2 | -2 | [-2] |
| **1** | `max(1, -2 + 1)` | 1 | 1 | [1] |
| **-3** | `max(-3, 1 + -3)` | -2 | 1 | [1] |
| **4** | `max(4, -2 + 4)` | 4 | 4 | [4] |
| **-1** | `max(-1, 4 + -1)` | 3 | 4 | [4] |
| **2** | `max(2, 3 + 2)` | 5 | 5 | [4, -1, 2] |
| **1** | `max(1, 5 + 1)` | 6 | 6 | [4, -1, 2, 1] |
| **-5** | `max(-5, 6 + -5)` | 1 | 6 | [4, -1, 2, 1] |
| **4** | `max(4, 1 + 4)` | 5 | 6 | [4, -1, 2, 1] |

After iterating through the entire array, the `global_max` is **6**. The subarray corresponding to this sum is `[4, -1, 2, 1]`.

The core idea is that at each step, we're making a locally optimal choice that contributes to the globally optimal solution. If the `current_max` becomes negative at any point, it's better to start a new subarray from the next element, as a negative sum will only decrease the sum of any future subarray it's a part of.