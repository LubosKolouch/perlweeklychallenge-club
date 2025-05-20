import unittest


def rank_array(ints: list[int]) -> list[int]:
    """
    Given an array of integers, return an array of ranks for each element.
    The lowest value has rank 1, the next lowest rank 2, and so on.
    If two elements are the same, they share the same rank.

    Args:
        ints (List[int]): A list of integers.

    Returns:
        List[int]: A list of ranks corresponding to the input integers.
    """
    # Create a sorted list of unique elements
    sorted_unique = sorted(set(ints))

    # Create a dictionary to map each number to its rank
    rank_map = {num: rank + 1 for rank, num in enumerate(sorted_unique)}

    # Replace each number in the original array with its rank
    return [rank_map[num] for num in ints]


class TestRankArray(unittest.TestCase):

    def test_examples(self):
        self.assertEqual(rank_array([55, 22, 44, 33]), [4, 1, 3, 2],
                         "Example 1")
        self.assertEqual(rank_array([10, 10, 10]), [1, 1, 1], "Example 2")
        self.assertEqual(rank_array([5, 1, 1, 4, 3]), [4, 1, 1, 3, 2],
                         "Example 3")

    def test_empty_array(self):
        self.assertEqual(rank_array([]), [], "Empty array")

    def test_single_element(self):
        self.assertEqual(rank_array([42]), [1], "Single element")

    def test_negative_numbers(self):
        self.assertEqual(rank_array([-10, -20, -10, -30]), [3, 2, 3, 1],
                         "Negative numbers")

    def test_mixed_numbers(self):
        # Corrected expected output
        self.assertEqual(rank_array([0, -1, 1, -1, 2]), [2, 1, 3, 1, 4],
                         "Mixed numbers")


if __name__ == "__main__":
    unittest.main()
