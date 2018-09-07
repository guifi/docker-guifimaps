# Set the base image
FROM debian:stretch

LABEL net.guifi.vendor="Fundacio guifi.net"
LABEL version="1.0"
LABEL description="This docker image is ready for \
developing with guifimaps services"
LABEL maintainer="roger.garcia@guifi.net"


ENV GMAPS_UNIX_USER guifi
ENV GMAPS_USER_ID 1000
ENV GMAPS_USER_GID 1000
ENV GUIFI_WEB guifi.net

RUN apt-get update && apt-get dist-upgrade -y \
  && apt-get install -y php7.0 \
  php7.0-xml wget gosu cgi-mapserver \
  git gdal-bin php7.0-curl \
  && apt-get clean \
  && apt-get autoremove \
  && rm -rf /var/lib/apt/lists/*

# Copy apache conf file
COPY ./guifimaps.conf /etc/apache2/sites-available/guifimaps.conf

# Enable new site
RUN a2enmod rewrite \
  && a2enmod cgi \
  && a2dissite 000-default.conf \
  && a2ensite guifimaps.conf

  # Creating UNIX User for development (security reasons)
  RUN groupadd --gid "${GMAPS_USER_GID}" "${GMAPS_UNIX_USER}" && \
      useradd \
        --uid ${GMAPS_USER_ID} \
        --gid ${GMAPS_USER_GID} \
        --create-home \
        --shell /bin/bash \
        ${GMAPS_UNIX_USER}

# Copying script for setting userid and gid (host)
COPY user-mapping.sh /
RUN  chmod u+x user-mapping.sh

# Setting Volume
VOLUME /home/$GMAPS_UNIX_USER

# Copying Entrypoint scripts
COPY ./docker-entrypoint.sh /
COPY ./guifimaps-entry.pl /

# Copying utilities
COPY ./refresh.sh /

EXPOSE 80

WORKDIR /home/$GMAPS_UNIX_USER

ENTRYPOINT ["/docker-entrypoint.sh"]
