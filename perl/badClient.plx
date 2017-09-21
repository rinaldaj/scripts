#!/bin/perl

use IO::Socket::INET;

$| = 1;

my $socket = new IO::Socket::INET (
	PeerHost => '127.0.0.1',
	PeerPort => '8080',
	Proto => 'tcp'
);

my $req = 'hello world';
$socket->send($req);

shutdown($socket,1);

$response = "";
$socket->recv($response,1024);

print "$response";
