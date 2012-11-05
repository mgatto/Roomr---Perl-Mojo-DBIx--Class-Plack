use utf8;
package Schema::Result::Reservation;

use Modern::Perl;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/ PK::Auto InflateColumn::DateTime Core Ordered /);
__PACKAGE__->position_column('start');

__PACKAGE__->table('reservations');
# @todo import DateTime Component
__PACKAGE__->add_columns(
    id => {
        data_type => 'integer',
        is_auto_increment => 1,
    },
    room_id => {
        data_type => 'integer',
        is_nullable => 0,
    },
    reserved_for_id => {
        data_type => 'integer',
        is_nullable => 0,
    },
    start => {
        data_type => 'timestamp',
        is_nullable => 0,
        size => 19
    },
    end => {
        data_type => 'timestamp',
        is_nullable => 0,
        size => 19
    },
);
__PACKAGE__->set_primary_key('id');
# Relations
__PACKAGE__->belongs_to(room => 'Schema::Result::Room', 'room_id');
__PACKAGE__->has_one(holder => 'Schema::Result::Person', 'reserved_for_id');

1;
