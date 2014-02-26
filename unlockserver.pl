#!/usr/bin/env perl

use strict;
use warnings;

use Mojolicious::Lite;

# remember to add the following to your hosts-file
# 127.0.0.1 bf2web.gamespy.com

app->secret('secretbf2hackedserverxor');

get '/ASP/getunlocksinfo' => sub {
  my $self = shift;
  my $pid  = $self->param('pid');
  my $body;

  $self->app->log->info("Request made for pid: [$pid]");
  $body = stringify($pid);

  $self->res->headers->content_type('text/html; charset=utf-8');
  $self->res->body($body);
  $self->res->fix_headers;
  $self->res->headers->header( 'Cache-Control'    => 'private' );
  $self->res->headers->header( 'Server'           => 'Microsoft-IIS/6.0' );
  $self->res->headers->header( 'X-AspNet-Version' => '2.0.50727' );
  $self->res->headers->header( 'X-Powered-By'     => 'ASP.NET' );
  $self->res->headers->header( 'cluster-server'   => 'gstpsprdweb08' );
  $self->res->headers->header( 'p3p'              => q(CP='NOI ADMa OUR STP') );

  $self->write($body);
  $self->finish();
};

# next route is only necessary if you dont run a dedicated server
get '/*uniqueblah' => sub {
  my $self   = shift;
  my $all    = $self->param('uniqueblah');
  my @params = $self->param;
  my $params;
  foreach my $param (@params) {
    next if $param eq 'uniqueblah';
    $params .= "$param=" . $self->param($param) . '&';
  }
  my $path = "69.10.24.134/$all?$params";
  $self->app->log->debug("Irrelevant URL. Forwarding to $all.");
  my $response = $self->ua->get( $path => { Host => 'bf2web.gamespy.com' } );
  $self->render( text => $response->res->body );
};

app->start;

sub stringify {
  my $pid   = shift;
  my $epoch = time;

  my $string = "O\n";
  $string .= "H\tpid\tnick\tasof\n";
  $string .= "D\t$pid\tsomeone\t$epoch\n";
  $string .= "H\tenlisted\tofficer\n";
  $string .= "D\t0\t0\n";
  $string .= "H\tid\tstate\n";
  $string .= "D\t11\ts\n";
  $string .= "D\t22\ts\n";
  $string .= "D\t33\ts\n";
  $string .= "D\t44\ts\n";
  $string .= "D\t55\ts\n";
  $string .= "D\t66\ts\n";
  $string .= "D\t77\ts\n";
  $string .= "D\t88\ts\n";
  $string .= "D\t99\ts\n";
  $string .= "D\t111\ts\n";
  $string .= "D\t222\ts\n";
  $string .= "D\t333\ts\n";
  $string .= "D\t444\ts\n";
  $string .= "D\t555\ts\n";

  my $length = chars($string);

  $string .= "\$\t$length\t\$\n";
  return $string;
}

sub chars {
  my ($string) = @_;

  $string =~ s/\t//g;
  $string =~ s/\n//g;
  return length $string;
}

1;
