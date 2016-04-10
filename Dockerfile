FROM hypriot/rpi-alpine-scratch

# Create needed directories
RUN mkdir /config /blackhole /sorted /unsorted /app

# Install usefull binaries
RUN apk update && \
    apk --update add python git unrar zip unzip openssl py-openssl py-mako
    
# Get latests sickrage version
RUN git clone --depth 1 git://github.com/SickRage/SickRage.git /app

# Clean up
RUN rm -rf /var/cache/apk/*

VOLUME /config /blackhole /sorted /unsorted
EXPOSE 8081

CMD ["/usr/bin/env", "python2", "/app/SickBeard.py", "--datadir=/config", "--nolaunch"]
