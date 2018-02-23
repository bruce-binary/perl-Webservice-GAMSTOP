package Webservice::GAMSTOP;

use strict;
use warnings;

use Moo;

our $VERSION = '0.001';

=head1 NAME

Webservice::GAMSTOP - Module abstract

=head1 SYNOPSIS

    use Webservice::GAMSTOP;
    my $instance = Webservice::GAMSTOP->new({
        server_url => '<url>',
        api_key    => '<key>'
    });

    $instance->get_exclusion_for({
        first_name    => 'Harry',
        last_name     => 'Potter',
        email         => 'harry.potter@example.com',
        date_of_birth => '1970-01-01',
        postcode      => 'hp11aa',
    });

=head1 DESCRIPTION

This module implements a programmatic interface to
[GAMSTOP](https://www.gamstop.co.uk/) api.

=head1 PRE-REQUISITE

Before you can use this module, you'll need to obtain your
own "Unique API Key" from [GAMSTOP](https://www.gamstop.co.uk/).

=cut

=head1 METHODS

=head2 new

    my $instance = Webservice::GAMSTOP->new($hashref)

=head3 Required parameters

=over 4

* server_url - api endpoint
* api_key    - unique api key provided by GAMSTOP

=back

=cut

has server_url => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

has api_key => (
    is       => 'ro',
    isa      => 'Str',
    required => 1,
);

1;

=head1 AUTHOR

binary.com <cpan@binary.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2018 by binary.com.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.


=head1 SEE ALSO

=over 4

=item *

=back

