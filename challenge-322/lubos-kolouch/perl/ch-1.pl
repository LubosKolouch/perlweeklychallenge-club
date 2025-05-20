use strict;
use warnings;
use Test::More;

sub format_string {
    my ( $str, $i ) = @_;

    # Remove all dashes from the string
    $str =~ s/-//g;

    # Handle the first group separately
    my @groups;
    if ( length($str) > $i ) {
        my $first_group_size = length($str) % $i || $i;
        push @groups, substr( $str, 0, $first_group_size, '' );
    }

    # Split the remaining string into groups of size $i
    while ( length($str) > $i ) {
        push @groups, substr( $str, 0, $i, '' );
    }
    push @groups, $str if length($str) > 0;

    # Join the groups with dashes
    return join( '-', @groups );
}

# Unit tests
is( format_string( "ABC-D-E-F",   3 ), "ABC-DEF",     "Example 1" );
is( format_string( "A-BC-D-E",    2 ), "A-BC-DE",     "Example 2" );
is( format_string( "-A-B-CD-E",   4 ), "A-BCDE",      "Example 3" );
is( format_string( "123-456-789", 3 ), "123-456-789", "Numeric string" );
is( format_string( "----",        2 ), "",            "Only dashes" );
is( format_string( "A",           1 ), "A",           "Single character" );

done_testing();
