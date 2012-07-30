use utf8;
package Schema::Result::Reservation;

use Modern::Perl;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('reservations');
# @todo import DateTime Component
__PACKAGE__->add_columns(qw/id room_id reserved_for_id start end/);
__PACKAGE__->set_primary_key('id');
# Relations
__PACKAGE__->belongs_to(room => 'Schema::Result::Room', 'room_id');
# __PACKAGE__->has_one(holder => 'Schema::Result::Reserver', 'id');

1;
