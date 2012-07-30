#!perl -T

use Test::More tests => 1;

BEGIN {
    use_ok( 'Roomr' ) || print "Bail out!\n";
}

diag( "Testing Roomr $Roomr::VERSION, Perl $], $^X" );
