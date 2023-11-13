use strict;
use warnings;

use Random::Tree::Oracle;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Random::Tree::Oracle::VERSION, 0.01, 'Version.');
