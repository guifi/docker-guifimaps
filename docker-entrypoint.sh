# Configuration script in Perl
cron start
perl /guifimaps-entry.pl
gosu gmaps bash -c '( crontab -l ; echo "3,18,33,48 * * * *  cd /usr/share/guifimaps; php refresh.php > /dev/null 2>&1; cd data; rm -rf dlinks/*; rm -rf dnodes/*; ogr2ogr -f "ESRI Shapefile" dlinks dlinks.gml; ogr2ogr -f "ESRI Shapefile" dnodes dnodes.gml
" ) | crontab -'
/usr/sbin/apache2ctl -D FOREGROUND
