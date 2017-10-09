# Set the base image
FROM debian:stretch

LABEL net.guifi.vendor="Fundacio guifi.net"
LABEL version="1.0"
LABEL description="This docker image is ready for \
developing with guifimaps services"
LABEL maintainer="roger.garcia@guifi.net"


ENV GMAPS_UNIX_USER gmaps


RUN apt-get update && apt-get dist-upgrade -y \
  && apt-get install -y php7.0 \
  php7.0-xml wget gosu cgi-mapserver \
  git cron gdal-bin \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

# Copy apache conf file
COPY ./guifimaps.conf /etc/apache2/sites-available/guifimaps.conf

# Enable new site
RUN a2enmod rewrite
RUN a2enmod cgi
RUN a2dissite 000-default.conf
RUN a2ensite guifimaps.conf

# Preparing development dir
RUN mkdir /usr/share/guifimaps/

# Creating UNIX User for fiberfy (security reasons)
RUN groupadd --system $GMAPS_UNIX_USER && useradd --system --gid $GMAPS_UNIX_USER $GMAPS_UNIX_USER --create-home

# Setting Volume
VOLUME /usr/share/guifimaps/

# Copying Entrypoint scripts
COPY ./docker-entrypoint.sh /
COPY ./guifimaps-entry.pl /


EXPOSE 80

WORKDIR /usr/share/guifimaps/

ENTRYPOINT ["/docker-entrypoint.sh"]
