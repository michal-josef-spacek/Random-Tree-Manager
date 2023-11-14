use strict;
use warnings;

use Random::Tree::Oracle;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Random::Tree::Oracle->new;
my $ret = $obj->random;
isa_ok($ret, 'Tree');
