use lib '.';
use strict;
use warnings;

use inc::Module::Install;

# Definition.
abstract 'Generate random data for tree manager.';
author 'Michal Josef Spacek <skim@cpan.org>';
author_requires 'English' => 0;
author_requires 'File::Object' => 0;
author_requires 'Test::More' => 0;
author_requires 'Test::NoWarnings' => 0;
author_requires 'Test::Pod' => 0;
author_requires 'Test::Pod::Coverage' => 0;
license 'bsd';
name 'Random-Tree-Manager';
perl_version 5.008;
readme_from 'Manager.pm';
recursive_author_tests('xt');
requires 'Class::Utils' => 0;
requires 'Error::Pure' => 0;
requires 'Tree' => 0;
resources 'bugtracker' => 'https://github.com/michal-josef-spacek/Random-Tree-Manager/issues';
resources 'homepage' => 'https://github.com/michal-josef-spacek/Random-Tree-Manager';
resources 'repository' => 'git://github.com/michal-josef-spacek/Random-Tree-Manager';
test_requires 'Test::More' => 0;
test_requires 'Test::NoWarnings' => 0;
tests_recursive;
version '0.01';

# Run.
WriteAll();
