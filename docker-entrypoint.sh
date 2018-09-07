#!/bin/bash
# Configuration script in Perl
/user-mapping.sh
perl /guifimaps-entry.pl
gosu guifi /refresh.sh
chown -R $GMAPS_UNIX_USER:www-data /home/$GMAPS_UNIX_USER/maps.guifi.net/guifimaps/data
/usr/sbin/apache2ctl -D FOREGROUND
