#!/usr/local/bin/perl

use Set::Files;

chdir "t"  if (-d "t");

$ntest = 10;
$itest = 1;

print "Set::Files (Tagchar/Comment)...\n";
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

$q = new Set::Files("path"          => ["dir3"],
                    "types"         => ["type1","type2"],
                    "default_types" => "none",
                    "tagchars"      => ":",
                    "comment"       => "!.*"
                   );

&test("a",               join(" ",$q->list_sets));
&test("a",               join(" ",$q->list_sets("type1")));
&test("a ab abc ac",     join(" ",$q->members("a")));
&test("1",               $q->is_member("a","ab"));
&test("0",               $q->is_member("a","c"));
&test("type1 type2",     join(" ",$q->list_types));
&test("type1 type2",     join(" ",$q->list_types("a")));
&test("dir3",            join(" ",$q->dir("a")));
&test("1",               join(" ",$q->opts("a","a1")));
&test("vala2",           join(" ",$q->opts("a","a2")));

