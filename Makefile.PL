use ExtUtils::MakeMaker;
WriteMakefile(
   NAME => "Set::Files",
   VERSION_FROM => "Files.pm",
   ($] >= 5.005
      ? (ABSTRACT=>'routines to work with files, each definining a single set.',
         AUTHOR  =>'Sullivan Beck (sbeck@cpan.org)')
      : ()),
  'dist' => {COMPRESS=>'gzip',SUFFIX=>'gz'}
);
