package Random::Tree::Oracle;

use strict;
use warnings;

use Class::Utils qw(set_params);
use Error::Pure qw(err);
use Tree;

our $VERSION = 0.01;

sub new {
	my ($class, @params) = @_;

	# Create object.
	my $self = bless {}, $class;

	# Depth.
	$self->{'depth'} = 3;

	# Maximum number of childnodes.
	$self->{'max_childs'} = 4;

	# Process parameters.
	set_params($self, @params);

	# Check depth.
	if (! defined $self->{'depth'}) {
		err "Parameter 'depth' is required.";
	}
	if ($self->{'depth'} !~ m/^\d+$/ms) {
		err "Parameter 'depth' must be a integer.";
	}
	if ($self->{'depth'} < 0) {
		err "Parameter 'depth' must contain number greater or equal than 0.";
	}

	# Check max_childs.
	if (! defined $self->{'max_childs'}) {
		err "Parameter 'max_childs' is required.";
	}
	if ($self->{'max_childs'} !~ m/^\d+$/ms) {
		err "Parameter 'max_childs' must be a integer.";
	}
	if ($self->{'max_childs'} < 0) {
		err "Parameter 'max_childs' must contain number greater or equal than 0.";
	}

	# ID counter.
	$self->{'_count'} = 0;

	return $self;
}

sub random {
	my $self = shift;

	my $tree = Tree->new('Root');
	$tree->meta({
		'id' => ++$self->{'_count'},
		'parent' => '',
	});
	my $trees_to_process_ar = [$tree];
	foreach (1 .. $self->{'depth'}) {
		my @next_trees_to_process = ();
		foreach my $processing_tree (@{$trees_to_process_ar}) {
			push @next_trees_to_process, $self->_create_subtree($processing_tree);
		}
		$trees_to_process_ar = \@next_trees_to_process;
	}

	return $tree;
}

sub _create_subtree {
	my ($self, $tree) = @_;

	# Random number of subtrees.
	my $subtrees_count = int(rand($self->{'max_childs'} + 1));

	my $parent_id = $tree->meta->{'id'};

	my @new_trees = ();
	foreach (0 .. $subtrees_count) {
		my $new_tree = Tree->new;
		$new_tree->meta({
			'id' => ++$self->{'_count'},
			'parent' => $parent_id,
		});
		$tree->add_child($new_tree);
		push @new_trees, $new_tree;
	}

	return @new_trees;
}

1;

__END__
