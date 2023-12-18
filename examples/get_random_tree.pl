#!/usr/bin/env perl

use strict;
use warnings;

use Random::Tree::Manager;

# Object.
my $obj = Random::Tree::Manager->new;

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