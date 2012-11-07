use utf8;
package Schema::Result::Person;

use Modern::Perl;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('people');
__PACKAGE__->add_columns(qw/id first_name last_name/);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_one( account => 'Schema::Result::Account', 'id');

# needed for Mojo rendering of complex relationships in JSON
sub TO_JSON {
    my $self = shift;
    {
        id        => $self->id,
        first_name => $self->first_name,
        last_name  => $self->last_name,
    }
};

1;
