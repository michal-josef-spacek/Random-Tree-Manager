use strict;
use warnings;

use Random::Tree::Manager;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Random::Tree::Manager->new;
my $ret = $obj->random;
isa_ok($ret, 'Tree');
