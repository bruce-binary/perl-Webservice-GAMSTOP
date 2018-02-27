package Webservice::GAMSTOP::Response;

use strict;
use warnings;

=head1 NAME

Webservice::GAMSTOP::Response - Response object for get_exclusion_for sub

=head1 SYNOPSIS

    my $instance = Webservice::GAMSTOP->new(
        api_url => '<gamstop_api_url>',
        api_key => '<gamstop_api_key>',
        # optional (defaults to 5 seconds)
        timeout => 10,
    );

    my $response = $instance->get_exclusion_for(
        first_name    => 'Harry',
        last_name     => 'Potter',
        email         => 'harry.potter@example.com',
        date_of_birth => '1970-01-01',
        postcode      => 'hp11aa',
    );

    $response->is_excluded;
    $response->get_date;
    $response->get_unique_id

=head1 DESCRIPTION

This object is returned as response for get_exclusion_for.

=cut

=head1 METHODS

Constructor

=head2 new

    my $response = Webservice::GAMSTOP::Response->new(
        exclusion => '',
        date      => '',
        unique_id => '',
    );

=head3 Return value

A new Webservice::GAMSTOP::Response object

=cut

sub new {
    my ($class, %args) = @_;

    return bless \%args, $class;
}

=head2 is_excluded

Indicates whether user is self excluded or not

=head3 Return value

=over 4

True if user is excluded on GAMSTOP i.e GAMSTOP return a Y response

=back

GAMSTOP Response:

- When GAMSTOP returns a Y response the user is registered with the GAMSTOP
service with a valid current self-exclusion.

- When GAMSTOP returns an N response the user is not registered with the GAMSTOP
service.

- When GAMSTOP returns a P response the user was previously self-excluded using
the GAMSTOP service but their chosen minimum period of exclusion has lapsed
and they have requested to have their self-exclusion removed

=cut

sub is_excluded {
    my $flag = shift->{exclusion};

    if ($flag) {
        return 0 if $flag eq 'N' or $flag eq 'P';
        return 1 if $flag eq 'Y';
    }

    return 0;
}

=head2 get_unique_id

Unique id provided in response headers

=head3 Return value

=over 4

returns GAMSTOP unique id for request

=back

=cut

sub get_unique_id {
    return shift->{unique_id} // undef;
}

=head2 get_date

Date provided in response headers

=head3 Return value

=over 4

returns GAMSTOP response date

=back

=cut

sub get_date {
    return shift->{date} // undef;
}

1;
__END__

=head1 AUTHOR

binary.com <cpan@binary.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by binary.com.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

=cut
