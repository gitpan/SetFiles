#!/usr/local/bin/perl

use Set::Files;

chdir "t"  if (-d "t");

$ntest = 5;
$itest = 1;

print "Set::Files (Valid File)...\n";
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
                    "valid_file"    => '^a'
                   );

&test("a1 a2",           join(" ",$q->list_sets));

$q = new Set::Files("path"          => "dir4",
                    "invalid_quiet" => 1,
                    "valid_file"    => '2$'
                   );

&test("a2 b2",           join(" ",$q->list_sets));

$q = new Set::Files("path"          => "dir4",
                    "invalid_quiet" => 1,
                    "valid_file"    => '!^a'
                   );

&test("b1 b2",           join(" ",$q->list_sets));

$q = new Set::Files("path"          => "dir4",
                    "invalid_quiet" => 1,
                    "valid_file"    => '!2$'
                   );

&test("a1 b1",           join(" ",$q->list_sets));

sub valid_file {
  my($dir,$file) = @_;
  return 1  if ($file eq "a1"  ||  $file eq "b2");
  return 0;
}

$q = new Set::Files("path"          => "dir4",
                    "invalid_quiet" => 1,
                    "valid_file"    => \&valid_file
                   );

&test("a1 b2",           join(" ",$q->list_sets));

