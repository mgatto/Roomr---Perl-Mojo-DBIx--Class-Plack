use utf8;
package Schema::Result::Building;

use Modern::Perl;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('buildings');
__PACKAGE__->add_columns(qw/id name description/);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many( rooms => 'Schema::Result::Room', 'id');
1;
