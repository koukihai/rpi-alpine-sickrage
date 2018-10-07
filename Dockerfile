FROM multiarch/alpine:armhf-latest-stable

# Install useful binaries
RUN apk add --update \
	python \
	git \
	unrar zip unzip \
	openssl py-openssl py-mako

# Clean up
RUN rm -rf /var/cache/apk/*

# Check if user sickrage exists, create it if not
RUN id sickrage || adduser -S -s /bin/false -H -D sickrage
RUN addgroup sickrage users

# Create needed directories
RUN mkdir -p /config /blackhole /sorted /unsorted /app && \
    chmod 775 /config /blackhole /sorted /unsorted && \
    chgrp -R users /blackhole /unsorted /sorted && \
	chown -R sickrage:users /config /app

# Continue as user sickrage
USER sickrage
  
# Get latests sickrage version
RUN git clone --depth 1 git://github.com/SickRage/SickRage.git /app

VOLUME /config /blackhole /sorted /unsorted
EXPOSE 8081

CMD ["/usr/bin/env", "python2", "/app/SickBeard.py", "--datadir=/config", "--nolaunch"]
