use 5.006;
use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Roomr',
    AUTHOR              => q{mgatto <mgatto@lisantra.com>},
    VERSION_FROM        => 'lib/Roomr.pm',
    ABSTRACT_FROM       => 'lib/Roomr.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Roomr-*' },
);
