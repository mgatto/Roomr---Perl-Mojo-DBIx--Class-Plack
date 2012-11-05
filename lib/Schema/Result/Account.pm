use utf8;
package Schema::Result::Account;

use Modern::Perl;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('accounts');
__PACKAGE__->add_columns(qw/id username password/);
__PACKAGE__->set_primary_key('id');
## __PACKAGE__->has_one( pe => 'Schema::Result::Room', 'id');
1;
