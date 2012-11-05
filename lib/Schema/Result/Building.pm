use utf8;
package Schema::Result::Building;

use Modern::Perl;
use base qw/DBIx::Class/;

__PACKAGE__->load_components(qw/ Core Ordered /);
__PACKAGE__->position_column('name');

__PACKAGE__->table('buildings');
__PACKAGE__->add_columns(
    'id' =>  {
        data_type         => 'integer',
        is_auto_increment => 1,
    },
    'name' => {
        data_type => 'char',
        is_nullable => 0,
        size => 128
    },
    'description' => {
        data_type   => 'char',
        is_nullable => 1,
        size        => 255
    },
    'slug' => {
        data_type   => "char",
        is_nullable => 1,
        size        => 255
    },
);

__PACKAGE__->set_primary_key('id');
__PACKAGE__->has_many( rooms => 'Schema::Result::Room', 'id');

1;
