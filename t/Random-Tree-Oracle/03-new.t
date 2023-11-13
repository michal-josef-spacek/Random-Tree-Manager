use strict;
use warnings;

use Random::Tree::Oracle;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
my $obj = Random::Tree::Oracle->new;
isa_ok($obj, 'Random::Tree::Oracle');
