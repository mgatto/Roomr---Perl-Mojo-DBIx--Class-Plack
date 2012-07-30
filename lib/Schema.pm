use utf8;
package Schema;

use Modern::Perl;
use base qw/DBIx::Class::Schema/;

our $VERSION = 0.01;

__PACKAGE__->load_namespaces();

1;
