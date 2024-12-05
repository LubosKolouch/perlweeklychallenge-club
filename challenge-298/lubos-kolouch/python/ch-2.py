import unittest
import bisect


def find_right_intervals(intervals: list[list[int]]) -> list[int]:
    """
    Finds the right interval index for each interval in the input list.

    Args:
        intervals (List[List[int]]): A list of intervals where each interval
            is represented as [start_i, end_i] and start_i is unique.

    Returns:
        List[int]: A list of indices representing the right interval for each input interval.
            If no right interval exists for an interval, the value at that index is -1.
    """
    n = len(intervals)
    # Extract start points with their original indices
    start_points = sorted([(interval[0], idx) for idx, interval in enumerate(intervals)])
    starts = [sp[0] for sp in start_points]
    result = []

    for interval in intervals:
        end_i = interval[1]
        # Use bisect to find the insertion point for end_i
        idx = bisect.bisect_left(starts, end_i)
        if idx < n:
            # Append the index of the right interval
            result.append(start_points[idx][1])
        else:
            # No right interval found
            result.append(-1)

    return result


# Unit Tests
class TestFindRightIntervals(unittest.TestCase):

    def test_example1(self):
        intervals = [[3, 4], [2, 3], [1, 2]]
        expected = [-1, 0, 1]
        self.assertEqual(find_right_intervals(intervals), expected, 'Example 1 failed')

    def test_example2(self):
        intervals = [[1, 4], [2, 3], [3, 4]]
        expected = [-1, 2, -1]
        self.assertEqual(find_right_intervals(intervals), expected, 'Example 2 failed')

    def test_example3(self):
        intervals = [[1, 2]]
        expected = [-1]
        self.assertEqual(find_right_intervals(intervals), expected, 'Example 3 failed')

    def test_example4(self):
        intervals = [[1, 4], [2, 2], [3, 4]]
        expected = [-1, 1, -1]
        self.assertEqual(find_right_intervals(intervals), expected, 'Example 4 failed')

    def test_no_right_intervals(self):
        intervals = [[5, 6], [1, 2], [3, 4]]
        expected = [-1, 2, 0]
        self.assertEqual(find_right_intervals(intervals), expected, 'No right intervals failed')

    def test_all_right_intervals(self):
        intervals = [[1, 2], [2, 3], [3, 4]]
        expected = [1, 2, -1]
        self.assertEqual(find_right_intervals(intervals), expected, 'All right intervals failed')

    def test_same_start_and_end(self):
        intervals = [[1, 1], [3, 3], [2, 2]]
        expected = [0, 1, 2]
        self.assertEqual(find_right_intervals(intervals), expected, 'Same start and end failed')

    def test_large_intervals(self):
        intervals = [[i, i + 1] for i in range(1000)]
        expected = list(range(1, 1000)) + [-1]
        self.assertEqual(find_right_intervals(intervals), expected, 'Large intervals failed')


if __name__ == '__main__':
    unittest.main()
