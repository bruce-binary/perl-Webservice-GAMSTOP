# perl-Gamstop

This module provides an interface to [GAMSTOP](https://www.gamstop.co.uk/) api.

GAMSTOP is an online self-exclusion service enabling consumers resident within
the UK to voluntarily exclude themselves from all British-licensed remote
gambling operators.

# NAME
    Webservice::GAMSTOP - GAMSTOP API Client Implementation

# SYNOPSIS
        use Webservice::GAMSTOP;
        my $instance = Webservice::GAMSTOP->new(
            api_url => '<gamstop_api_url>',
            api_key => '<gamstop_api_key>',
            # optional (defaults to 5 seconds)
            timeout => 10,
        );

        $instance->get_exclusion_for(
            first_name    => 'Harry',
            last_name     => 'Potter',
            email         => 'harry.potter@example.com',
            date_of_birth => '1970-01-01',
            postcode      => 'hp11aa',
        );

# DESCRIPTION
    This module implements a programmatic interface to
    [GAMSTOP](https://www.gamstop.co.uk/) api.

# PRE-REQUISITE
    Before you can use this module, you'll need to obtain your own "Unique
    API Key" from [GAMSTOP](https://www.gamstop.co.uk/).

# METHODS
  ## get_exclusion_for
    Given user details return exclusion response object

   ### Required parameters
    *   first_name : First name of person, only 20 characters are
        significant

    *   last_name : Last name of person, only 20 characters are significant

    *   date_of_birth: Date of birth in ISO format (yyyy-mm-dd)

    *   email : Email address

    *   postcode : Postcode (spaces not significant)

   ### Optional parameters
    *   x_trace_id: A freeform field that is put into audit log that can be
        used by the caller to identify a request. This might be something to
        indicate the person being checked, a unique request ID, GUID, or a
        trace ID from a system such as zipkin.

   ### Return value
   *    A Webservice::GAMSTOP::Response object

# AUTHOR
    binary.com <cpan@binary.com>

# COPYRIGHT AND LICENSE
    This software is copyright (c) 2018 by binary.com.

    This is free software; you can redistribute it and/or modify it under
    the same terms as the Perl 5 programming language system itself.
