#!/usr/local/bin/perl

use Set::Files;

chdir "t"  if (-d "t");

$ntest = 4;
$itest = 1;

print "Set::Files (Read File)...\n";
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

$q = new Set::Files("path"          => "dir5"
                   );

&test("a b c",           join(" ",$q->list_sets));

$q = new Set::Files("path"          => "dir5",
                    "read"          => "file",
                    "set"           => "a"
                   );

&test("a",               join(" ",$q->list_sets));

$q = new Set::Files("path"          => "dir5",
                    "read"          => "file",
                    "set"           => "b"
                   );

&test("a b",             join(" ",$q->list_sets));

$q = new Set::Files("path"          => "dir5",
                    "read"          => "file",
                    "set"           => "c"
                   );

&test("a b c",           join(" ",$q->list_sets));

