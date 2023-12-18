use strict;
use warnings;

use Test::More 'tests' => 3;
use Test::NoWarnings;

BEGIN {

	# Test.
	use_ok('Random::Tree::Manager');
}

# Test.
require_ok('Random::Tree::Manager');
