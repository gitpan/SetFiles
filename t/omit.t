#!/usr/local/bin/perl

use Set::Files;

chdir "t"  if (-d "t");

$ntest = 13;
$itest = 1;

print "Set::Files (Omit)...\n";
print "1..$ntest\n";

$in  = new IO::File;
$out = new IO::File;

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
sub init {
  $in->open("dir2a/a.orig");
  $out->open("> dir2a/a");
  @in = <$in>;
  foreach $line (@in) {
    print $out $line;
  }
  $in->close;
  $out->close;

  $q = new Set::Files("path"          => ["dir2a","dir2b"],
                      "types"         => ["type1","type2"],
                      "invalid_quiet" => 1,
                      "valid_file"    => '!(orig|out)$',
                      "default_types" => "none"
                     );
  return $q;
}

$q = &init();
&test("a b c",           join(" ",$q->list_sets));
&test("a b",             join(" ",$q->list_sets("type1")));
&test("a ab abc b",      join(" ",$q->members("a")));
&test("ab abc b bc",     join(" ",$q->members("b")));
&test("1",               $q->is_member("a","ab"));
&test("0",               $q->is_member("a","c"));
&test("type1 type2",     join(" ",$q->list_types));
&test("type1 type2",     join(" ",$q->list_types("a")));
&test("type1",           join(" ",$q->list_types("b")));
&test("dir2a",           join(" ",$q->dir("a")));
&test("dir2b",           join(" ",$q->dir("c")));
&test("1",               join(" ",$q->opts("a","a1")));
&test("vala2",           join(" ",$q->opts("a","a2")));

