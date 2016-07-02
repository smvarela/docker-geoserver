# Docker Geoserver
Docker image with Geoserver and print-plugin.

## What's included
- Ubuntu 16.04 as base image
- Oracle Java 8
- Geoserver
     - Geoserver version 2.9.0
     - Geoserver printing plugin

## Usage
With this dockerfile you can build the image:
```
docker build -f dockerfile.txt -t user/geoserver-master:test .
```
Run the Docker image:
```
docker run -it --net="host" user/geoserver-master:test
```
Start Geoserver in the new Docker terminal:
```
./startup.sh
```
