# rpi-alpine-sickrage

[Sickrage](https://sickrage.github.io/) is an automatic Video Library Manager for TV Shows.  
It watches for new episodes of your favorite shows, and when they are posted it does its magic: automatic torrent/nzb searching, downloading, and processing at the qualities you want.  

# Summary
This image is designed to run Sickrage on Raspberry Pi.  
It is based on Alpine Linux to make it as lightweight as possible.  

# Usage
```
docker run -d --name sickrage \
  -v /etc/localtime:/etc/localtime:ro \
  -v /media/conf/sickrage:/config \
  -v /media/TVShows/:/sorted \
  -v /media/Unsorted:/unsorted \
  -v /media/blackhole:/blackhole \
  -p 8081:8081 \
  koukihai/rpi-alpine-sickrage
```
where:  
`/media/conf/sickrage` is the folder on the host where you will store sickrage configurations  
`/media/TVShows` is the folder on the host where you will store completed and organized downloads  
`/media/Unsorted` is the folder on the host where you will store incomplete files  
`/media/blackhole` is... just in case you need to plug a blackhole listener  

# Details
Sickrage daemon will run as `sickrage:users`  
Ensure that the `users` group has write permissions on the mapped volumes

# Credits
https://hub.docker.com/r/sickrage/sickrage/

