#!/bin/bash
# Configuration script in Perl
perl /guifimaps-entry.pl
/refresh.sh
/usr/sbin/apache2ctl -D FOREGROUND
