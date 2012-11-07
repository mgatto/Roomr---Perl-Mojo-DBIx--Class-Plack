use utf8;
package Schema::Result::Account;

use Modern::Perl;
use base qw/DBIx::Class::Core/;

__PACKAGE__->table('accounts');
__PACKAGE__->add_columns(qw/id person_id username password/);
__PACKAGE__->set_primary_key('id');
__PACKAGE__->belongs_to(person => 'Schema::Result::Person', 'person_id');

# needed for Mojo rendering of complex relationships in JSON
sub TO_JSON {
    my $self = shift;
    {
        id        => $self->id,
        person_id => $self->person_id,
        username  => $self->username,
    }
};

1;

