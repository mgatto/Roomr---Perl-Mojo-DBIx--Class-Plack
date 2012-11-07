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
    person_id => {
        data_type => 'integer',
        is_nullable => 0,
    },
    start => {
        data_type => 'datetime',
        is_nullable => 0,
        size => 19
    },
    end => {
        data_type => 'datetime',
        is_nullable => 0,
        size => 19
    },
);
__PACKAGE__->set_primary_key('id');

# Relations
__PACKAGE__->belongs_to(room => 'Schema::Result::Room', 'room_id');
__PACKAGE__->has_one(reserver => 'Schema::Result::Person', 'id');

# needed for Mojo rendering of complex relationships in JSON
sub TO_JSON {
    my $self = shift;
    {
        id          => $self->id,
        room_id     => $self->room->id,
        room_name   => $self->room->name,
        person_id   => $self->person_id,
        person_name => $self->reserver->first_name . " " . $self->reserver->last_name,
        start       => $self->start,
        end         => $self->end,
    }
};


1;
