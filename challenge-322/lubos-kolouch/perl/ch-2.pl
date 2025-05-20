use strict;
use warnings;
use Test::More;

=pod

=head1 rank_array

Given an array of integers, return an array of ranks for each element.
The lowest value has rank 1, the next lowest rank 2, and so on.
If two elements are the same, they share the same rank.

=head2 Arguments

=over

=item * \@ints: Array reference of integers.

=back

=head2 Returns

=over

=item * Array reference of ranks corresponding to the input integers.

=back

=cut

sub rank_array {
    my ($ints) = @_;

    # Create a sorted list of unique elements
    my @sorted_unique = sort { $a <=> $b } keys %{ { map { $_ => 1 } @$ints } };

    # Create a hash to map each number to its rank
    my %rank_map;
    for my $rank ( 0 .. $#sorted_unique ) {
        $rank_map{ $sorted_unique[$rank] } = $rank + 1;
    }

    # Replace each number in the original array with its rank
    return [ map { $rank_map{$_} } @$ints ];
}

# Unit tests
is_deeply( rank_array( [ 55, 22, 44, 33 ] ),     [ 4, 1, 3, 2 ],    "Example 1" );
is_deeply( rank_array( [ 10, 10, 10 ] ),         [ 1, 1, 1 ],       "Example 2" );
is_deeply( rank_array( [ 5, 1, 1, 4, 3 ] ),      [ 4, 1, 1, 3, 2 ], "Example 3" );
is_deeply( rank_array( [] ),                     [],                "Empty array" );
is_deeply( rank_array( [42] ),                   [1],               "Single element" );
is_deeply( rank_array( [ -10, -20, -10, -30 ] ), [ 3, 2, 3, 1 ],    "Negative numbers" );
is_deeply( rank_array( [ 0, -1, 1, -1, 2 ] ),    [ 2, 1, 3, 1, 4 ], "Mixed numbers" );

done_testing();
