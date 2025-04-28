use strict;
use warnings;
use Test::More;

sub can_reverse_to_match {
    my ( $source, $target ) = @_;

    # Return false if arrays are not the same length
    return 0 unless @$source == @$target;

    # Return true if arrays are already equal
    return 1 if join( ',', @$source ) eq join( ',', @$target );

    # Find the first and last indices where the arrays differ
    my ( $start, $end );
    for my $i ( 0 .. $#$source ) {
        if ( $source->[$i] != $target->[$i] ) {
            $start = $i unless defined $start;
            $end   = $i;
        }
    }

    # If no differing indices were found, return false
    return 0 unless defined $start && defined $end;

    # Reverse the subarray in the source array
    my @reversed = @$source;
    @reversed[ $start .. $end ] = reverse @reversed[ $start .. $end ];

    # Check if reversing the subarray makes the arrays equal
    return join( ',', @reversed ) eq join( ',', @$target ) ? 1 : 0;
}

# Unit tests
is( can_reverse_to_match( [ 3, 2, 1, 4 ], [ 1, 2, 3, 4 ] ), 1, 'Example 1' );
is( can_reverse_to_match( [ 1, 3, 4 ],    [ 4, 1, 3 ] ),    0, 'Example 2' );
is( can_reverse_to_match( [2],            [2] ),            1, 'Example 3' );
is( can_reverse_to_match( [ 1, 2, 3 ],    [ 1, 3, 2 ] ),    1, 'Reverse middle subarray' );
is( can_reverse_to_match( [ 1, 2, 3 ],    [ 3, 2, 1 ] ),    1, 'Reverse entire array' );
is( can_reverse_to_match( [ 1, 2, 3 ],    [ 1, 2, 4 ] ),    0, 'Different elements' );

done_testing();
