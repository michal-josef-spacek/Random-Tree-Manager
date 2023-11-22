use strict;
use warnings;

use English;
use Error::Pure::Utils qw(clean);
use Random::Tree::Oracle;
use Test::More 'tests' => 8;
use Test::NoWarnings;

# Test.
my $obj = Random::Tree::Oracle->new;
isa_ok($obj, 'Random::Tree::Oracle');

# Test.
eval {
	Random::Tree::Oracle->new('');
};
is($EVAL_ERROR, "Unknown parameter ''.\n", 'Bad \'\' parameter.');
clean();

# Test.
eval {
	Random::Tree::Oracle->new(
		'something' => 'value',
	);
};
is($EVAL_ERROR, "Unknown parameter 'something'.\n",
	'Bad \'something\' parameter.');
clean();

# Test.
eval {
	Random::Tree::Oracle->new(
		'depth' => undef,
	);
};
is($EVAL_ERROR, "Parameter 'depth' is required.\n",
	"Parameter 'depth' is required.");
clean();

# Test.
eval {
	Random::Tree::Oracle->new(
		'depth' => 'bad',
	);
};
is($EVAL_ERROR, "Parameter 'depth' must be a integer.\n",
	"Parameter 'depth' must be a integer.");
clean();

# Test.
eval {
	Random::Tree::Oracle->new(
		'max_children' => undef,
	);
};
is($EVAL_ERROR, "Parameter 'max_children' is required.\n",
	"Parameter 'max_children' is required.");
clean();

# Test.
eval {
	Random::Tree::Oracle->new(
		'max_children' => 'bad',
	);
};
is($EVAL_ERROR, "Parameter 'max_children' must be a integer.\n",
	"Parameter 'max_children' must be a integer.");
clean();
