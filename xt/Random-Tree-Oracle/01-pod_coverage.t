use strict;
use warnings;

use Test::NoWarnings;
use Test::Pod::Coverage 'tests' => 2;

# Test.
pod_coverage_ok('Random::Tree::Oracle', 'Random::Tree::Oracle is covered.');
