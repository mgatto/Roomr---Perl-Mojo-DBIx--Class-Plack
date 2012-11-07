#!/usr/bin/env perl

use Mojolicious::Lite;
use Mojo::JSON;
use DBIx::Class::ResultClass::HashRefInflator;
use HTML::FormHandler;
use lib '/srv/www/roomr.local/v0.1/lib';
use Schema;

my $config = plugin Config => {file => 'conf/roomr.conf'};

helper db => sub {
    #return Schema->connect($self->config->{db}->{dsn}, $self->config->{db}->{username}, $self->config->{db}->{password}, \%dbi_params);
    return Schema->connect('dbi:SQLite:/srv/www/roomr.local/v0.1/roomr.db',"","");
};

# List buildings
get '/buildings' => sub {
    my $self = shift;

    my $rs = $self->db->resultset('Building');
    $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
    my @buildings = $rs->all();

    $self->respond_to(
        json  => {json => [@buildings]},
        html => {
            template => 'buildings',
            buildings => [@buildings],
        }
    );
};

# List rooms
# @TODO should display visual cues about room
get '/building/:slug/rooms' => sub {
    my $self = shift;
    my $slug = $self->stash('slug');

    my $rs = $self->db->resultset('Room');
    $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
    # all() is what actually executes the search; 'In list context, all() is
    # called implicitly on the resultset, thus returning a list of row objects
    # instead. To avoid that, use "search_rs".'
    my @rooms_by_building = $rs->search({ 'building.slug' => $slug }, { join => 'building' })->all;

    $self->respond_to(
        json  => {json => [@rooms_by_building]},
        html => {
            template => 'rooms',
            rooms => [@rooms_by_building],
        }
    );
};

# Room details and reservations
get '/room/:slug' => sub {
    my $self = shift;
    my $slug  = $self->stash('slug');

    my $rs = $self->db->resultset('Reservation');
    $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');

    my @this_rooms_reservations = $rs->search_rs({}, { join => 'room' })->all();
    # search(  , { prefetch => ['room', 'reserver'] })
    #{ 'room.slug' => $slug }

    $self->respond_to(
        json  => {json => [@this_rooms_reservations]},
        html => {
            template => 'reservations',
            reservations => [@this_rooms_reservations],
        }
    );
};

# reserves a room for a block of time
get '/room/:slug/reservation/new' => sub {
    my $self = shift;
    my $slug  = $self->stash('slug');

    # create an inline form and render
    # must install module!
    #my $form = HTML::FormHandler::Model::DBIC->new(
    #    item_id         => $id,
    #    item_class    => 'Reservation',
    #    schema          => $schema,
    #    field_list         => [
    #            name    => 'Text',
    #            active  => 'Boolean',
    #            submit_btn => 'Submit',
    #    ],
    #);
    my $form = HTML::FormHandler->new(
        field_list => [
            'room_id'      => { type => 'Hidden', default => $slug },
            'start'        => { type => 'DateTime' },
            'start.month'  => { type => 'Month' },
            'start.day'    => { type => 'MonthDay' },
            'start.year'   => { type => 'Year' },
            'start.hour'   => { type => 'Hour' },
            'start.minute' => { type => 'Minute' },
            'end'          => { type => 'DateTime'},
            'end.month'    => { type => 'Month' },
            'end.day'      => { type => 'MonthDay' },
            'end.year'     => { type => 'Year' },
            'end.hour'     => { type => 'Hour' },
            'end.minute'   => { type => 'Minute' },
            'submit_btn'   => { type => 'Submit' },
        ],
    );

    $self->respond_to(
        json  => {json => ["Error: Invalid Context"]},
        html => {
            template => 'new_reservation',
            slug     => $slug,
            form     => $form->render,
        }
    );
};

# Save a new reservation
post '/room/:slug/reservation/save' => sub {
    my $self = shift;
    my $name  = $self->stash('slug');

};


# Edit a reservation
get '/room/:slug/reservation/edit' => sub {
    my $self = shift;
    my $room_name  = $self->stash('slug');

};

# Cancel a reservation
post '/room/:slug/reservation/cancel' => sub {
    my $self = shift;
    my $room_name  = $self->stash('slug');

};

app->start();
