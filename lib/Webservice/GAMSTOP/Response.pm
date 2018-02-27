package Webservice::GAMSTOP::Response;

use strict;
use warnings;

=head1 NAME

Webservice::GAMSTOP::Response - Response object for get_exclusion_for sub

=head1 SYNOPSIS

    my $response = Webservice::GAMSTOP->new(...)->get_exclusion_for(...);
    $response->is_excluded;
    $response->get_date;
    $response->get_unique_id

=head1 DESCRIPTION

This object is returned as response for get_exclusion_for.

=cut

=head2 METHODS

=head3 is_excluded

=head4 Return value

True if user is excluded on GAMSTOP i.e GAMSTOP return a Y response

GAMSTOP Response:

- When GAMSTOP returns a Y response the user is registered with the GAMSTOP
service with a valid current self-exclusion.

- When GAMSTOP returns an N response the user is not registered with the GAMSTOP
service.

- When GAMSTOP returns a P response the user was previously self-excluded using
the GAMSTOP service but their chosen minimum period of exclusion has lapsed
and they have requested to have their self-exclusion removed

=over 4

=back

=head3 get_date

=head4 Return value

returns GAMSTOP response date (provided in response headers)

=over 4

=back

=head3 get_unique_id

=head4 Return value

returns GAMSTOP unique id for request (provided in response headers)

=over 4

=back

=cut

sub new {
    my ($class, %args) = @_;

    return bless \%args, $class;
}

sub is_excluded {
    my $flag = shift->{exclusion};

    if ($flag) {
        return 0 if $flag eq 'N' or $flag eq 'P';
        return 1 if $flag eq 'Y';
    }

    return 0;
}

sub get_unique_id {
    return shift->{unique_id} // undef;
}

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
