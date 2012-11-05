use utf8;
package Schema::Result::Person;

use Modern::Perl;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('people');
__PACKAGE__->add_columns(qw/id first_name last_name/);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_one( account => 'Schema::Result::Account', 'id');
1;
