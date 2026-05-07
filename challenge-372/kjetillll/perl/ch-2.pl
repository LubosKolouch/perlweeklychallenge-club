use List::Util 'max';

sub f {
    my $max;
    shift =~ qr(
        (.) .* \1
        (??{ $max = max( $max, length($&) - 2 ); '^' })
    )x;
    $max
}

print f($$_[0]) == $$_[1] ? "ok\n" : "ERROR\n" for
    [ "aaaaa"     =>  3 ],
    [ "abcdeba"   =>  5 ],
    [ "abbc"      =>  0 ],
    [ "abcaacbc"  =>  4 ],
    [ "laptop"    =>  2 ],
    [ "yuwqrtywvenotetuhgonwehoftwnherothvpqwereartnpwertunvpwerutpwenrtiwerntvpwehgcfeo" => 70],
    #  __wqrtywvenotetuhgonwehoftwnherothvpqwereartnpwertunvpwerutpwenrtiwerntvpw_______
    [ "yuwqrtywvenotetuhgonwehoftwnherothvpqwereartnpwertunvpwerutpwenrtiwerntvpxehgcfeo" => 69],
    #  _________enotetuhgonwehoftwnherothvpqwereartnpwertunvpwerutpwenrtiwerntvpxehgcfe_
