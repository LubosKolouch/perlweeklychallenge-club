"""
Challenge 322 Task 1
"""

import unittest


def format_string(input_str: str, group_size: int) -> str:
    """
    Format the string by removing dashes and grouping characters in sizes of `group_size`.
    The first group can be smaller but must have at least one character.

    Args:
        input_str (str): The input string containing characters and dashes.
        group_size (int): The size of each group after formatting.

    Returns:
        str: The formatted string with groups separated by dashes.
    """
    # Remove all dashes from the string
    cleaned_str = input_str.replace("-", "")
    # Initialize the result
    result = []
    # Calculate the size of the first group
    first_group_size = len(cleaned_str) % group_size or group_size
    # Add the first group
    result.append(cleaned_str[:first_group_size])
    # Add the remaining groups
    for i in range(first_group_size, len(cleaned_str), group_size):
        result.append(cleaned_str[i:i + group_size])
    # Join groups with dashes
    return "-".join(result)


class TestFormatString(unittest.TestCase):
    """Test cases for the format_string function."""

    def test_example_1(self):
        """Test the first example."""
        input_str = "ABC-D-E-F"
        group_size = 3
        expected_output = "ABC-DEF"
        self.assertEqual(format_string(input_str, group_size), expected_output)

    def test_example_2(self):
        """Test the second example."""
        input_str = "A-BC-D-E"
        group_size = 2
        expected_output = "A-BC-DE"
        self.assertEqual(format_string(input_str, group_size), expected_output)

    def test_example_3(self):
        """Test the third example."""
        input_str = "-A-B-CD-E"
        group_size = 4
        expected_output = "A-BCDE"
        self.assertEqual(format_string(input_str, group_size), expected_output)


if __name__ == "__main__":
    unittest.main()
