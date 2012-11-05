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
    $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
    my @buildings = $rs->all;

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
get '/building/:name/rooms' => sub {
    my $self = shift;
    my $building_name = $self->stash('name');

    my $rs = $self->db->resultset('Room');
    $rs->result_class('DBIx::Class::ResultClass::HashRefInflator');
    my @all_rooms = $rs->all;

    $self->respond_to(
        json  => {json => [@all_rooms]},
        html => {
            template => 'rooms',
            rooms => [@all_rooms],
        }
    );

};

# Room details
get '/room/:name' => sub {
    my $self = shift;
    my $room_name  = $self->stash('name');

    my @this_rooms_reservations = $self->db->resultset('Reservations')->all;

    $self->render('reservations', reservations => @this_rooms_reservations);
};

# reserves a room for a block of time
post '/room/:name/reserve' => sub {
    my $self = shift;
    my $name  = $self->stash('name');

};

# Edit a reservation
post '/room/:name/edit' => sub {
    my $self = shift;
    my $room_name  = $self->stash('name');

};

# Cancel a reservation
post '/room/:name/cancel' => sub {
    my $self = shift;
    my $room_name  = $self->stash('name');

};

app->start();
