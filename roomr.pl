#!/usr/bin/env perl

use Mojolicious::Lite;
use lib 'lib';
use Schema;

my $config = plugin Config => {file => 'conf/roomr.conf'};

helper db => sub {
    #return Schema->connect($self->config->{db}->{dsn}, $self->config->{db}->{username}, $self->config->{db}->{password}, \%dbi_params);
    return Schema->connect('dbi:SQLite:roomr.db');
};

# listing of rooms
# @TODO should display visual cues about room
get '/' => sub {
    my $self = shift;
    my @all_rooms = $self->db->resultset('Room')->all;

    $self->render('rooms', rooms => @all_rooms);
};

# room details
get '/room/:name' => sub {
    my $self = shift;
    my $name  = $self->stash('name');

    my @this_rooms_reservations = $self->db->resultset('Reservations')->all;

    $self->render('reservations', reservations => @this_rooms_reservations);
};

# reserves a room for a block of time
post '/room/:name/reserve' => sub {
    my $self = shift;

    my $name  = $self->stash('name');
};

app->start();
