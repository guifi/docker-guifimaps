#!/usr/bin/perl
# This script configures fiberfy for first time
#
use warnings;
use strict;


print "Checking configurations...\n";

if (! -e "INSTALLED") {

    my $output = `rm -rf {,.[!.],..?}*`;
    if ($? != 0) {
        # Error
        die "Error erasing all volume.\n";
    }

    $output = `git init && git remote add origin https://github.com/guifi/guifimaps.git \\
                && git fetch && git checkout -t origin/master`;
    if ($? != 0) {
        # Error
        die "Error getting code from git repository.\n";
    }

    $output = `chown -R $ENV{GMAPS_UNIX_USER}:$ENV{GMAPS_UNIX_USER} .`;
    if ($? != 0) {
        # Error
        die "Error changing permissions.\n";
    }

    $output = `gosu $ENV{GMAPS_UNIX_USER} ( crontab -l ; echo "30 18 * * * /bin/true" ) | crontab -`;
    if ($? != 0) {
        # Error
        die "Error installing cron command.\n";
    }

    # make INSTALLED file
    $output = `touch INSTALLED`;
    if ($? != 0) {
     # Error
     die "Error creating INSTALLED file.\n";
    }

    print "Guifi.net guifimaps successfully installed in Docker image!\n";
}
else {
    print "Already installed.\n";
}
