FROM hypriot/rpi-alpine-scratch

# Install usefull binaries
RUN apk update && \
    apk --update add python git unrar zip unzip openssl py-openssl py-mako

# Clean up
RUN rm -rf /var/cache/apk/*

# Check if user sickrage exists, if not, create it
RUN id sickrage || adduser -S -s /bin/false -H -D sickrage
RUN addgroup sickrage users

# Create directories that we need
RUN mkdir -p /config /blackhole /sorted /unsorted /app && \
    chmod 775 /config /blackhole /sorted /unsorted && \
    chgrp -R users /blackhole /unsorted /sorted
RUN chown -R sickrage:users /config /app

# Continue as user "sickrage"
USER sickrage
  
# Get the latest version of sickrage
RUN git clone --depth 1 git://github.com/SickRage/SickRage.git /app

VOLUME /config /blackhole /sorted /unsorted
EXPOSE 8081

CMD ["/usr/bin/env", "python2", "/app/SickBeard.py", "--datadir=/config", "--nolaunch"]
