package Webservice::GAMSTOP;

use strict;
use warnings;

use Moo;
use Mojo::UserAgent;

our $VERSION = '0.001';

=head1 NAME

Webservice::GAMSTOP - GAMSTOP API Client Implementation

=head1 SYNOPSIS

    use Webservice::GAMSTOP;
    my $instance = Webservice::GAMSTOP->new(
        api_url => '<url>',
        api_key => '<key>'
    );

    $instance->get_exclusion_for(
        first_name    => 'Harry',
        last_name     => 'Potter',
        email         => 'harry.potter@example.com',
        date_of_birth => '1970-01-01',
        postcode      => 'hp11aa',
    );

=head1 DESCRIPTION

This module implements a programmatic interface to
[GAMSTOP](https://www.gamstop.co.uk/) api.

=head1 PRE-REQUISITE

Before you can use this module, you'll need to obtain your
own "Unique API Key" from [GAMSTOP](https://www.gamstop.co.uk/).

=cut

=head1 METHODS

=head2 new

    my $instance = Webservice::GAMSTOP->new(...)

=head3 Required parameters

=over 4

* api_url: GAMSTOP api endpoint
* api_key: unique api key provided by GAMSTOP

=back

=head3 Optional parameters

=over 4

* timeout: specify a timeout (default to 5 seconds)

=back

=head3 Return value

A new Webservice::GAMSTOP object

=cut

has api_url => (
    is       => 'ro',
    required => 1,
);

has api_key => (
    is       => 'ro',
    required => 1,
);

has timeout => (
    is      => 'ro',
    default => 5,
);

=head2 get_exclusion_for

Given user details return exclusion response

=head3 Required parameters

=over 4

* first_name   : First name of person, only 20 characters are significant
* last_name    : Last name of person, only 20 characters are significant
* date_of_birth: Date of birth in ISO format (yyyy-mm-dd)
* email        : Email address
* postcode     : Postcode - spaces not significant

=back

=over 4 Optional parameters

x_trace_id: A freeform field that is put into audit log that can be used
by the caller to identify a request. This might be something to indicate
the person being checked, a unique request ID, GUID, or a trace ID from
a system such as zipkin.

=back

=cut

sub get_exclusion_for {
    my ($self, %args) = @_;

    die "Missing required parameter: first_name."    unless (exists $args{'first_name'});
    die "Missing required parameter: last_name."     unless (exists $args{'last_name'});
    die "Missing required parameter: date_of_birth." unless (exists $args{'date_of_birth'});
    die "Missing required parameter: email."         unless (exists $args{'email'});
    die "Missing required parameter: postcode."      unless (exists $args{'postcode'});

    my $ua = Mojo::UserAgent->new;
    $ua->connect_timeout($self->timeout);

    # required parameters
    my $form_params = {
        firstName   => $args{first_name},
        lastName    => $args{last_name},
        dateOfBirth => $args{date_of_birth},
        email       => $args{email},
        postcode    => $args{postcode},
    };

    # optional parameters
    $form_params->{'X-Trace-Id'} = $args{'x_trace_id'} if $args{'x_trace_id'};

    $ua->on(
        start => sub {
            my ($ua, $tx) = @_;
            $tx->req->headers->header('X-API-Key' => $self->api_key);
        });

    my $tx = $ua->post($self->api_url => form => $form_params);

    if (my $response = $tx->success) {
        my $headers = $response->headers;
        return Webservice::GAMSTOP::Response->_new({
            exclusion => $headers->header('x-exclusion'),
            date      => $headers->header('date'),
            unique_id => $headers->header('x-unique-id'),
        });
    } else {
        my $err = $tx->error;
        die $err->{code} . ' response: ' . $err->{message} if $err->{code};
        die 'Connection error: ' . $err->{message};
    }

    return Webservice::GAMSTOP::Response->_new(
        exclusion => undef,
        date      => undef,
        unique_id => undef,
    );
}

package Webservice::GAMSTOP::Response;

sub _new {
    my ($class, $query) = @_;
    my $self = \$query;
    bless $self, $class;

    sub get_unique_id {
        return shift->{unique_id};
    }

    sub get_date {
        return shift->{date};
    }

    sub is_excluded {
        my $flag = shift->{exclusion};

        # GAMSTOP Matching Service should return one of three valid
        # responses, a Y, a N, or a P
        if ($flag) {
            return 0 if $flag eq 'N';

            return 1 if $flag eq 'Y' or $flag eq 'P';
        }

        return 0;
    }
}

1;
__END__

=head1 AUTHOR

binary.com <cpan@binary.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by binary.com.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=back

