use strict;
use warnings;
use Test::More tests => 8;

sub find_right_intervals {
    my (@intervals) = @_;
    my $n = scalar @intervals;
    my @start_points;
    for my $idx ( 0 .. $#intervals ) {
        push @start_points, [ $intervals[$idx][0], $idx ];
    }

    # Sort start points
    @start_points = sort { $a->[0] <=> $b->[0] } @start_points;
    my @starts = map { $_->[0] } @start_points;
    my @result;

    for my $interval (@intervals) {
        my $end_i = $interval->[1];

        # Binary search for minimal start_j >= end_i
        my ( $left, $right ) = ( 0, $n - 1 );
        my $idx = -1;
        while ( $left <= $right ) {
            my $mid = int( ( $left + $right ) / 2 );
            if ( $start_points[$mid][0] >= $end_i ) {
                $idx   = $mid;
                $right = $mid - 1;
            }
            else {
                $left = $mid + 1;
            }
        }
        if ( $idx != -1 ) {
            push @result, $start_points[$idx][1];
        }
        else {
            push @result, -1;
        }
    }
    return @result;
}

# Unit Tests

is_deeply( [ find_right_intervals( [ 3, 4 ], [ 2, 3 ], [ 1, 2 ] ) ], [ -1, 0, 1 ],  'Example 1' );
is_deeply( [ find_right_intervals( [ 1, 4 ], [ 2, 3 ], [ 3, 4 ] ) ], [ -1, 2, -1 ], 'Example 2' );
is_deeply( [ find_right_intervals( [ 1, 2 ] ) ],                     [-1],          'Example 3' );
is_deeply( [ find_right_intervals( [ 1, 4 ], [ 2, 2 ], [ 3, 4 ] ) ], [ -1, 1, -1 ], 'Example 4' );

# Additional Test Cases
is_deeply( [ find_right_intervals( [ 5, 6 ], [ 1, 2 ], [ 3, 4 ] ) ], [ -1, 2,  0 ], 'No right intervals' );
is_deeply( [ find_right_intervals( [ 1, 2 ], [ 2, 3 ], [ 3, 4 ] ) ], [  1, 2, -1 ], 'All right intervals' );
is_deeply( [ find_right_intervals( [ 1, 1 ], [ 3, 3 ], [ 2, 2 ] ) ], [  0, 1,  2 ], 'Same start and end' );

# Test Large Intervals
my @large_intervals = map { [ $_, $_ + 1 ] } ( 0 .. 999 );
my @expected        = ( 1 .. 999, -1 );
is_deeply( [ find_right_intervals(@large_intervals) ], \@expected, 'Large intervals' );

done_testing();
