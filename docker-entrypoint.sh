#!/bin/bash
# Configuration script in Perl
cron start
perl /guifimaps-entry.pl
gosu $GMAPS_UNIX_USER bash -c '( crontab -l ; echo "3,18,33,48 * * * *  cd /usr/share/guifimaps; export GUIFI_WEB=$GUIFI_WEB;php refresh.php > /dev/null 2>&1; cd data; rm -rf dlinks/*; rm -rf dnodes/*; ogr2ogr -f "ESRI Shapefile" dlinks dlinks.gml; ogr2ogr -f "ESRI Shapefile" dnodes dnodes.gml
" ) | crontab -'
/usr/sbin/apache2ctl -D FOREGROUND
