use strict;
use warnings;

use Random::Tree::Manager;
use Test::More 'tests' => 2;
use Test::NoWarnings;

# Test.
is($Random::Tree::Manager::VERSION, 0.01, 'Version.');
