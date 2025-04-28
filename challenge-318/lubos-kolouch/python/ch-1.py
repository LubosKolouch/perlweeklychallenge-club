import unittest


def find_groups(s: str) -> list[str]:
    """
    Find all groups of three or more consecutive identical letters in a string.

    Args:
        s (str): The input string of lowercase letters.

    Returns:
        List[str]: A list of groups found in the string. Returns an empty list if no groups are found.
    """
    groups = []
    i = 0
    while i < len(s):
        count = 1
        while i + 1 < len(s) and s[i] == s[i + 1]:
            count += 1
            i += 1
        if count >= 3:
            groups.append(s[i] * count)
        i += 1
    return groups


class TestFindGroups(unittest.TestCase):

    def test_example_1(self):
        self.assertEqual(find_groups("abccccd"), ["cccc"])

    def test_example_2(self):
        self.assertEqual(find_groups("aaabcddddeefff"), ["aaa", "dddd", "fff"])

    def test_example_3(self):
        self.assertEqual(find_groups("abcdd"), [])

    def test_no_groups(self):
        self.assertEqual(find_groups("abcdef"), [])

    def test_single_group(self):
        self.assertEqual(find_groups("aaa"), ["aaa"])

    def test_multiple_groups(self):
        self.assertEqual(find_groups("aaabbbccc"), ["aaa", "bbb", "ccc"])


if __name__ == "__main__":
    unittest.main()
