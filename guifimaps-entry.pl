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

    $output = `mkdir -p maps.guifi.net/guifimaps`;
    if ($? != 0) {
        # Error
        die "Error creating necessary subdirs.\n";
    }

    $output = `cd maps.guifi.net/guifimaps && git init && git remote add origin https://github.com/guifi/guifimaps.git \\
                && git fetch && git checkout -t origin/docker`;
    if ($? != 0) {
        # Error
        die "Error getting code from git repository.\n";
    }

    $output = `cd maps.guifi.net/guifimaps && chown -R $ENV{GMAPS_UNIX_USER}:www-data . && chown -R $ENV{GMAPS_UNIX_USER}:www-data ./data`;
    if ($? != 0) {
        # Error
        die "Error changing permissions.\n";
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
