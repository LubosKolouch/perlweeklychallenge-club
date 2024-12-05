import unittest


def maximal_square(matrix: list[list[int]]) -> int:
    """
    Finds the area of the largest square containing only 1's in a binary matrix.

    Args:
        matrix (List[List[int]]): The input binary matrix.

    Returns:
        int: The area of the largest square.
    """
    if not matrix or not matrix[0]:
        return 0

    rows = len(matrix)
    cols = len(matrix[0])
    max_side = 0

    # Initialize DP table
    dp = [[0] * cols for _ in range(rows)]

    for i in range(rows):
        for j in range(cols):
            if matrix[i][j] == 1:
                if i == 0 or j == 0:
                    # First row or column
                    dp[i][j] = 1
                else:
                    # Take minimum of left, top, and top-left neighbors
                    dp[i][j] = min(dp[i - 1][j], dp[i][j - 1], dp[i - 1][j - 1]) + 1
                # Update max side length
                max_side = max(max_side, dp[i][j])
            else:
                dp[i][j] = 0

    return max_side ** 2


# Unit Tests
class TestMaximalSquare(unittest.TestCase):

    def test_example1(self):
        matrix = [[1, 0, 1, 0, 0], [1, 0, 1, 1, 1], [1, 1, 1, 1, 1], [1, 0, 0, 1, 0]]
        self.assertEqual(maximal_square(matrix), 4, 'Example 1 failed')

    def test_example2(self):
        matrix = [[0, 1], [1, 0]]
        self.assertEqual(maximal_square(matrix), 1, 'Example 2 failed')

    def test_example3(self):
        matrix = [[0]]
        self.assertEqual(maximal_square(matrix), 0, 'Example 3 failed')

    def test_empty_matrix(self):
        self.assertEqual(maximal_square([]), 0, 'Empty matrix failed')

    def test_all_ones(self):
        matrix = [[1, 1], [1, 1]]
        self.assertEqual(maximal_square(matrix), 4, 'All ones failed')

    def test_single_zero(self):
        matrix = [[0]]
        self.assertEqual(maximal_square(matrix), 0, 'Single zero failed')

    def test_single_one(self):
        matrix = [[1]]
        self.assertEqual(maximal_square(matrix), 1, 'Single one failed')

    def test_large_matrix(self):
        matrix = [[1] * 5 for _ in range(5)]
        self.assertEqual(maximal_square(matrix), 25, 'Large matrix failed')


if __name__ == '__main__':
    unittest.main()
