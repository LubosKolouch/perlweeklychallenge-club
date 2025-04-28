use strict;
use warnings;
use Test::More;

# Higher-order function to find groups
sub find_groups {
    my ($str) = @_;
    my @groups;

    # Use regex to find groups of 3 or more consecutive letters
    while ( $str =~ /([a-z])\1{2,}/g ) {
        push @groups, $&;
    }

    return @groups;
}

# Main script
sub group_position {
    my ($str) = @_;
    my @groups = find_groups($str);
    return @groups ? @groups : ('');
}

# Unit tests
sub run_tests {
    is_deeply( [ group_position("abccccd") ],        ["cccc"],                 'Test case 1' );
    is_deeply( [ group_position("aaabcddddeefff") ], [ "aaa", "dddd", "fff" ], 'Test case 2' );
    is_deeply( [ group_position("abcdd") ],          [""],                     'Test case 3' );
    is_deeply( [ group_position("aabbcc") ],         [""],                     'Test case 4 (no groups)' );
    is_deeply( [ group_position("aaa") ],            ["aaa"],                  'Test case 5 (single group)' );
    is_deeply( [ group_position("") ],               [""],                     'Test case 6 (empty string)' );
    done_testing();
}

# Run tests
run_tests();
