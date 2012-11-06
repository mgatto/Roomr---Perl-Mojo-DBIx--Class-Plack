#!/usr/bin/env perl

use Mojolicious::Lite;
use Mojo::JSON;
use DBIx::Class::ResultClass::HashRefInflator;
# /srv/www/roomr.local/current/
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
    #$rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
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
    # $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
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

# Room details
get '/room/:slug' => sub {
    my $self = shift;
    my $room_name  = $self->stash('name');

    my $rs = $self->db->resultset('Reservations');
    my @this_rooms_reservations = $rs->all();

    $self->render('reservations', reservations => @this_rooms_reservations);
};

# reserves a room for a block of time
post '/room/:slug/reserve' => sub {
    my $self = shift;
    my $name  = $self->stash('name');

};

# Edit a reservation
post '/room/:slug/reservation/edit' => sub {
    my $self = shift;
    my $room_name  = $self->stash('name');

};

# Cancel a reservation
post '/room/:slug/reservation/cancel' => sub {
    my $self = shift;
    my $room_name  = $self->stash('name');

};

app->start();
