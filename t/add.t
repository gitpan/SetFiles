#!/usr/local/bin/perl

use Set::Files;

chdir "t"  if (-d "t");

$ntest = 16;
$itest = 1;

print "Set::Files (Add/Remove)...\n";
print "1..$ntest\n";

$in = new IO::File;
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
sub test2 {
  my($set,$num,$q)=@_;
  my $dir = $q->dir($set);
  my $diff = "$dir/.set_files.diff.$set.$num";
  system("diff $dir/$set.$num.out $dir/$set > $diff");
  if (-z $diff) {
    print "ok $itest\n";
  } else {
    print "Diff    : $set,$num\n";
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
$q->add("a",0,1, "b","y","z");
&test("a ab abc b y z",  join(" ",$q->members("a")));
&test2("a",1,$q);

$q = &init();
$q->add("a",1,1, "b","y","z");
&test("a ab abc b y z",  join(" ",$q->members("a")));
&test2("a",2,$q);

$q = &init();
$q->add("a",0,1, "ac","b","y","z");
&test("a ab abc ac b y z",  join(" ",$q->members("a")));
&test2("a",3,$q);

$q = &init();
$q->add("a",1,1, "ac","b","y","z");
&test("a ab abc ac b y z",  join(" ",$q->members("a")));
&test2("a",4,$q);

$q = &init();
$q->add("a",0,0, "b","y","z");
$q->remove("a",0,1, "ab","y","yy");
&test("a abc b z",       join(" ",$q->members("a")));
&test2("a",5,$q);

$q = &init();
$q->add("a",0,0, "b","y","z");
$q->remove("a",1,1, "ab","y","yy");
&test("a abc b z",       join(" ",$q->members("a")));
&test2("a",6,$q);

$q = &init();
$q->add("a",0,1, "ac");
&test("a ab abc ac b",  join(" ",$q->members("a")));
&test2("a",7,$q);

$q = &init();
$q->add("a",0,1, "bc");
&test("a ab abc b bc",  join(" ",$q->members("a")));
&test2("a",8,$q);

