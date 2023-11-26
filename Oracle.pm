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

=pod

=encoding utf8

=head1 NAME

Random::Tree::Oracle - Class for random day generation.

=head1 SYNOPSIS

 use Random::Tree::Oracle;

 my $obj = Random::Tree::Oracle->new(%params);
 my $tree = $obj->random;

=head1 METHODS

=head2 C<new>

 my $obj = Random::Tree::Oracle->new(%params);

Constructor.

=over 8

=item * C<depth>

Depth.

Default value is 3.

=item * C<max_children>

Maximum number of children nodes.

Default value is 4.

=back

=head2 C<random>

 my $tree = $obj->random;

Get random tree.
Tree has metadata with keys:

=over

=item * C<id>

=item * C<parent>

=back

Returns instance of L<Tree>.

=head1 ERRORS

 new():
         From Class::Utils::set_params():
                 Unknown parameter '%s'.
         Parameter '%s' is required.
         Parameter '%s' must be a integer.

=head1 EXAMPLE

=for comment filename=get_random_tree.pl

 use strict;
 use warnings;

 use Random::Tree::Oracle;

 # Object.
 my $obj = Random::Tree::Oracle->new;

 # Get tree.
 my $tree = $obj->random;

 # Print out.
 print map("$_\n", @{$tree -> tree2string});

 # Output like:
 # . Attributes: {id => "1", parent => ""}
 #     |--- . Attributes: {id => "2", parent => "1"}
 #          |--- . Attributes: {id => "3", parent => "2"}
 #          |    |--- . Attributes: {id => "6", parent => "3"}
 #          |    |--- . Attributes: {id => "7", parent => "3"}
 #          |    |--- . Attributes: {id => "8", parent => "3"}
 #          |    |--- . Attributes: {id => "9", parent => "3"}
 #          |--- . Attributes: {id => "4", parent => "2"}
 #          |    |--- . Attributes: {id => "10", parent => "4"}
 #          |    |--- . Attributes: {id => "11", parent => "4"}
 #          |--- . Attributes: {id => "5", parent => "2"}
 #               |--- . Attributes: {id => "12", parent => "5"}
 #               |--- . Attributes: {id => "13", parent => "5"}
 #               |--- . Attributes: {id => "14", parent => "5"}

=head1 DEPENDENCIES

L<Class::Utils>,
L<Error::Pure>,
L<Tree>.

=head1 REPOSITORY

L<https://github.com/michal-josef-spacek/Random-Tree-Oracle>

=head1 AUTHOR

Michal Josef Špaček L<mailto:skim@cpan.org>

L<http://skim.cz>

=head1 LICENSE AND COPYRIGHT

© 2023 Michal Josef Špaček

BSD 2-Clause License

=head1 VERSION

0.01

=cut
