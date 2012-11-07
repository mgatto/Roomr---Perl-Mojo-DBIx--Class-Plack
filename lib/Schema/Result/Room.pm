use utf8;
package Schema::Result::Room;

use Modern::Perl;
use Unicode::Normalize;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/ PK::Auto InflateColumn::DateTime Core Ordered /);
__PACKAGE__->position_column('name');

__PACKAGE__->table('rooms');
__PACKAGE__->add_columns(
    # @todo how to setup as an auto increment?
    id => {
        data_type => 'integer',
        is_auto_increment => 1,
    },
    building_id => {
        data_type => 'integer',
    },
    name => {
        data_type => 'char',
        is_nullable => 0,
        size => 96
    },
    description => {
        data_type => 'char',
        is_nullable => 1,
        size => 255
    },
    picture => {
        data_type => 'char',
        is_nullable => 1,
        size => 128
    },
    capacity => {
        data_type => 'integer',
        is_nullable => 1,
        size => 5
    },
    #@TODO how to slug in DBIx::Class?
    slug => {
        data_type => "char",
        is_nullable => 1,
        size => 255
    },
);
__PACKAGE__->set_primary_key('id');

__PACKAGE__->has_many(reservations => 'Schema::Result::Reservation', 'id');
__PACKAGE__->belongs_to(building => 'Schema::Result::Building', 'building_id');

# needed for Mojo rendering of complex relationships in JSON
sub TO_JSON {
    my $self = shift;
    {
        id          => $self->id,
        building_id => $self->building_id,
        name        => $self->name,
        description => $self->description,
        picture     =>$self->picture,
        capacity    => $self->capacity,
        slug        => $self->slug,
    }
};

# @todo should a result class contain a slugifier?
# @todo or, use this: https://metacpan.org/module/String::Dirify, with Text::Unidecode? for betond ASCII
sub slugify($) {
    my ($input) = @_;

    $input = NFKD($input);         # Normalize the Unicode string
    $input =~ tr/\000-\177//cd;    # Strip non-ASCII characters (>127)
    $input =~ s/[^\w\s-]//g;       # Remove all characters that are not word characters (includes _), spaces, or hyphens
    $input =~ s/^\s+|\s+$//g;      # Trim whitespace from both ends
    $input = lc($input);
    $input =~ s/[-\s]+/-/g;        # Replace all occurrences of spaces and hyphens with a single hyphen

    return $input;
}

1;
