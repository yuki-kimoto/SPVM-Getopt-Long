use Test::More;

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin/lib";
BEGIN { $ENV{SPVM_BUILD_DIR} = "$FindBin::Bin/.spvm_build"; }

use SPVM 'TestCase::Getopt::Long';

use SPVM 'Getopt::Long';
use SPVM::Getopt::Long;
use SPVM 'Fn';

my $api = SPVM::api();

my $start_memory_blocks_count = $api->get_memory_blocks_count;

ok(SPVM::TestCase::Getopt::Long->test);

# Version check
{
  my $version_string = SPVM::Fn->get_version_string("Getopt::Long");
  is($SPVM::Getopt::Long::VERSION, $version_string);
}

my $end_memory_blocks_count = $api->get_memory_blocks_count;
is($end_memory_blocks_count, $start_memory_blocks_count);

done_testing;
