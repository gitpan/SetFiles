#!/usr/local/bin/perl

use Set::Files;

chdir "t"  if (-d "t");

$ntest = 3;
$itest = 1;

print "Set::Files (Valid Ele)...\n";
print "1..$ntest\n";

sub test {
  my($a,$b)=@_;
  if ($a eq $b) {
    print "ok $itest\n";
  } else {
    print "Expected: $a\n";
    print "Got     : $b\n";
    print "not ok $itest\n";
  }
  $itest++;
}

$q = new Set::Files("path"          => "dir4",
                    "invalid_quiet" => 1,
                    "valid_ele"     => '^(a|b)'
                   );

&test("a b",             join(" ",$q->members("a1")));

$q = new Set::Files("path"          => "dir4",
                    "invalid_quiet" => 1,
                    "valid_ele"     => '!(a|b)'
                   );

&test("c d",             join(" ",$q->members("a1")));

sub valid_ele {
  my($set,$ele) = @_;
  return 1  if ($ele eq "a"  ||  $ele eq "d");
  return 0;
}

$q = new Set::Files("path"          => "dir4",
                    "invalid_quiet" => 1,
                    "valid_ele"     => \&valid_ele
                   );

&test("a d",             join(" ",$q->members("a1")));

