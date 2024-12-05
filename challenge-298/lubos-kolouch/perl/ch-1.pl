use strict;
use warnings;
use Test::More tests => 8;

sub maximal_square {
    my ($matrix_ref) = @_;
    my @matrix = @$matrix_ref;

    return 0 unless @matrix && @{ $matrix[0] };

    my $rows     = scalar @matrix;
    my $cols     = scalar @{ $matrix[0] };
    my $max_side = 0;

    # Initialize DP table
    my @dp;
    for my $i ( 0 .. $rows - 1 ) {
        for my $j ( 0 .. $cols - 1 ) {
            $dp[$i][$j] = 0;
        }
    }

    for my $i ( 0 .. $rows - 1 ) {
        for my $j ( 0 .. $cols - 1 ) {
            if ( $matrix[$i][$j] == 1 ) {
                if ( $i == 0 || $j == 0 ) {

                    # First row or column
                    $dp[$i][$j] = 1;
                }
                else {
                    # Take minimum of left, top, and top-left neighbors
                    $dp[$i][$j] =
                      1 + List::Util::min( $dp[ $i - 1 ][$j], $dp[$i][ $j - 1 ], $dp[ $i - 1 ][ $j - 1 ] );
                }

                # Update max side length
                $max_side = $dp[$i][$j] if $dp[$i][$j] > $max_side;
            }
            else {
                $dp[$i][$j] = 0;
            }
        }
    }

    return $max_side * $max_side;
}

# Unit Tests

use List::Util qw(min);

# Test Example 1
my @matrix1 = ( [ 1, 0, 1, 0, 0 ], [ 1, 0, 1, 1, 1 ], [ 1, 1, 1, 1, 1 ], [ 1, 0, 0, 1, 0 ] );
is( maximal_square( \@matrix1 ), 4, 'Example 1' );

# Test Example 2
my @matrix2 = ( [ 0, 1 ], [ 1, 0 ] );
is( maximal_square( \@matrix2 ), 1, 'Example 2' );

# Test Example 3
my @matrix3 = ( [0] );
is( maximal_square( \@matrix3 ), 0, 'Example 3' );

# Test Empty Matrix
my @empty_matrix = ();
is( maximal_square( \@empty_matrix ), 0, 'Empty matrix' );

# Test All Ones
my @all_ones = ( [ 1, 1 ], [ 1, 1 ] );
is( maximal_square( \@all_ones ), 4, 'All ones' );

# Test Single Zero
my @single_zero = ( [0] );
is( maximal_square( \@single_zero ), 0, 'Single zero' );

# Test Single One
my @single_one = ( [1] );
is( maximal_square( \@single_one ), 1, 'Single one' );

# Test Large Matrix
my @large_matrix = map { [ (1) x 5 ] } ( 1 .. 5 );
is( maximal_square( \@large_matrix ), 25, 'Large matrix' );

done_testing();
