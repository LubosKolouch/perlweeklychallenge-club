import unittest


def can_reverse_to_match(source: list[int], target: list[int]) -> bool:
    """
    Determine if one array can be made equal to another by reversing exactly one contiguous subarray.

    Args:
        source (List[int]): The source array of integers.
        target (List[int]): The target array of integers.

    Returns:
        bool: True if the source array can be made equal to the target array by reversing one subarray, False otherwise.
    """
    # Return False if arrays are not the same length
    if len(source) != len(target):
        return False

    # Return True if arrays are already equal
    if source == target:
        return True

    # Find the first and last indices where the arrays differ
    start, end = None, None
    for i in range(len(source)):
        if source[i] != target[i]:
            if start is None:
                start = i
            end = i

    # If no differing indices were found, return False
    if start is None or end is None:
        return False

    # Reverse the subarray in the source array
    reversed_source = source[:start]
    reversed_source += source[start:end + 1][::-1] + source[end + 1:]

    # Check if reversing the subarray makes the arrays equal
    return reversed_source == target


class TestCanReverseToMatch(unittest.TestCase):

    def test_example_1(self):
        self.assertTrue(can_reverse_to_match([3, 2, 1, 4], [1, 2, 3, 4]),
                        "Example 1")

    def test_example_2(self):
        self.assertFalse(can_reverse_to_match([1, 3, 4], [4, 1, 3]),
                         "Example 2")

    def test_example_3(self):
        self.assertTrue(can_reverse_to_match([2], [2]), "Example 3")

    def test_reverse_middle_subarray(self):
        self.assertTrue(can_reverse_to_match([1, 2, 3], [1, 3, 2]),
                        "Reverse middle subarray")

    def test_reverse_entire_array(self):
        self.assertTrue(can_reverse_to_match([1, 2, 3], [3, 2, 1]),
                        "Reverse entire array")

    def test_different_elements(self):
        self.assertFalse(can_reverse_to_match([1, 2, 3], [1, 2, 4]),
                         "Different elements")

    def test_different_lengths(self):
        self.assertFalse(can_reverse_to_match([1, 2, 3], [1, 2]),
                         "Different lengths")

    def test_no_reversal_needed(self):
        self.assertTrue(can_reverse_to_match([1, 2, 3], [1, 2, 3]),
                        "No reversal needed")


if __name__ == "__main__":
    unittest.main()
