#!/bin/bash
gosu $GMAPS_UNIX_USER bash -c 'cd /home/guifi/maps.guifi.net/guifimaps; php refresh.php > /dev/null 2>&1; cd data; rm -rf dlinks/*; rm -rf dnodes/*; ogr2ogr -f "ESRI Shapefile" dlinks dlinks.gml; ogr2ogr -f "ESRI Shapefile" dnodes dnodes.gml'
chown -R $GMAPS_UNIX_USER:www-data /home/$GMAPS_UNIX_USER/maps.guifi.net/guifimaps/data
