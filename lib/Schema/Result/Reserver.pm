use utf8;
package Schema::Result::Reserver;

use Modern::Perl;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('reservers');
__PACKAGE__->add_columns(qw/id reservation_id person_id/);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many(reservations => 'Schema::Result::Reservation', 'reserved_for_id');

1;
