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

	# Maximum number of children nodes.
	$self->{'max_children'} = 4;

	# Process parameters.
	set_params($self, @params);

	$self->_check_req_positive_number('depth');
	$self->_check_req_positive_number('max_children');

	# ID counter.
	$self->{'_count'} = 0;

	return $self;
}

sub random {
	my $self = shift;

	my $tree = Tree->new;
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

sub _check_req_positive_number {
	my ($self, $key) = @_;

	# Check depth.
	if (! defined $self->{$key}) {
		err "Parameter '$key' is required.";
	}
	if ($self->{$key} !~ m/^\d+$/ms) {
		err "Parameter '$key' must be a integer.";
	}

	return;
}

sub _create_subtree {
	my ($self, $tree) = @_;

	# Random number of subtrees.
	my $subtrees_count = int(rand($self->{'max_children'} + 1));

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
