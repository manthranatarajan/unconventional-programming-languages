Read below for a description of each project.

# Racket Exercises Project

This project implements 10 exercises in the Racket programming language, demonstrating various functional programming concepts. Each function is implemented as described below:

1. **process-9**: A higher-order function that applies a given function to the integer 9.

2. **mymap**: A custom implementation of the `map` function using recursion to apply a given function to all elements of a list.

3. **second-min**: Finds the second smallest unique value in a list. Throws an error if fewer than two unique values exist.

4. **zipper**: Combines two lists into a list of pairs. Stops when the shorter list ends.

5. **classify**: Splits a list into two sublists based on a predicate: one where the predicate is true and another where it is false.

6. **member-n-times?**: Checks if an element appears exactly `n` times in a list.

7. **luhn**: Implements the Luhn algorithm to verify whether a number satisfies its checksum requirements.

8. **my-sorted?**: Verifies if a list is sorted according to a given comparison function.

9. **my-flatten**: Recursively flattens a nested list into a single-level list.

10. **my-list-ref**: Retrieves the element at a specific index in a list. Throws an error if the index is out of bounds.

Each function is designed to reinforce understanding of recursion, higher-order functions, and functional programming principles in Racket.



# Prolog Exercises Project

## Overview
This project is a collection of Prolog exercises that demonstrate solutions to various computational and logical problems. Each problem focuses on a specific task, such as list manipulation, prime number detection, classification, and more. The code is modular, well-documented, and provides valuable practice for Prolog learners.

## Exercises

### 1. List Product
- **Goal:** Calculate the product of all elements in a list.
- **Special Case:** If any element is `0`, the product is `0`.
- **Example Usage:**
  ```prolog
  ?- list_prod([2, 3, 4], Product).
  Product = 24.
  
  ?- list_prod([1, 0, 5], Product).
  Product = 0.
  ```

---

### 2. Prime Number Check
- **Goal:** Check if a given number is prime.
- **Implementation:** 
  - Uses a helper predicate `has_divisor/2` to test divisors up to the square root of the number.
- **Example Usage:**
  ```prolog
  ?- is_prime(7).
  true.
  
  ?- is_prime(9).
  false.
  ```

---

### 3. Second Minimum
- **Goal:** Find the second smallest unique element in a list.
- **Features:**
  - Handles duplicate elements.
  - Throws an error if the list contains non-numeric elements or fewer than two unique values.
- **Example Usage:**
  ```prolog
  ?- secondMin([4, 2, 5, 2, 3], SecondMin).
  SecondMin = 3.
  ```

---

### 4. Classify Elements
- **Goal:** Split a list into two based on a given predicate.
- **Example Usage:**
  ```prolog
  ?- classify(even, [1, 2, 3, 4], Evens, Odds).
  Evens = [2, 4],
  Odds = [1, 3].
  ```

---

### 5. Bookends
- **Goal:** Check if a given list has a specific prefix and suffix.
- **Example Usage:**
  ```prolog
  ?- bookends([1, 2], [3, 4], [1, 2, 5, 3, 4]).
  true.
  ```

---

### 6. Subslice
- **Goal:** Verify if one list is a contiguous subsequence of another.
- **Example Usage:**
  ```prolog
  ?- subslice([2, 3], [1, 2, 3, 4]).
  true.
  ```

---

### 7. Rotate List
- **Goal:** Rotate a list by `N` positions, both left and right.
- **Features:**
  - Handles both positive and negative shifts.
- **Example Usage:**
  ```prolog
  ?- rotate([1, 2, 3, 4], 2, Rotated).
  Rotated = [3, 4, 1, 2].
  ```

---

### 8. Luhn Algorithm
- **Goal:** Validate a number using the **Luhn checksum** (used in credit card validation).
- **Implementation:**
  - Doubles alternate digits and adjusts results greater than 9.
- **Example Usage:**
  ```prolog
  ?- luhn(49927398716).
  true.
  ```

---

### 9. Zebra Puzzle
- **Goal:** Solve the Zebra Puzzle (logic puzzle involving houses, colors, and nationalities).
- **Features:**
  - Uses positional and relational constraints.
- **Example Usage:**
  ```prolog
  ?- zebra_puzzle(Houses).
  ```

---

## Prerequisites
- Install a Prolog interpreter, such as **SWI-Prolog**.

---

## Running the Code
1. Open your Prolog interpreter.
2. Load the file containing the project:
   ```prolog
   ?- [project_file].
   ```
3. Run queries for the desired exercises.
