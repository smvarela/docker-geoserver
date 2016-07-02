# Pull base image
FROM ubuntu:16.04

# Install Ubuntu packages
RUN \
  apt-get update && \
  apt-get install -y software-properties-common unzip wget

# Install  Java
RUN \
  echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | debconf-set-selections && \
  add-apt-repository -y ppa:webupd8team/java && \
  apt-get update && \
  apt-get install -y oracle-java8-installer && \
  rm -rf /var/lib/apt/lists/* && \
  rm -rf /var/cache/oracle-jdk8-installer

# Define commonly used JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

 #
# Geoserver installation
# Stable version on 2016-06-14 is 2.9.0
#
ENV GEOSERVER_VERSION 2.9.0
ENV GEOSERVER_HOME=/usr/share/geoserver

# Get Geoserver
RUN mkdir $GEOSERVER_HOME
RUN wget http://ares.boundlessgeo.com/geoserver/release/$GEOSERVER_VERSION/geoserver-$GEOSERVER_VERSION-bin.zip
RUN cp geoserver-$GEOSERVER_VERSION-bin.zip $GEOSERVER_HOME
RUN unzip $GEOSERVER_HOME/geoserver-$GEOSERVER_VERSION-bin.zip -d $GEOSERVER_HOME
RUN rm $GEOSERVER_HOME/geoserver-$GEOSERVER_VERSION-bin.zip

# Get a Geoserver printing plugin
RUN wget http://ares.boundlessgeo.com/geoserver/release/$GEOSERVER_VERSION/plugins/geoserver-$GEOSERVER_VERSION-printing-plugin.zip
RUN cp geoserver-$GEOSERVER_VERSION-printing-plugin.zip $GEOSERVER_HOME
RUN unzip $GEOSERVER_HOME/geoserver-$GEOSERVER_VERSION-printing-plugin.zip -d $GEOSERVER_HOME/geoserver-$GEOSERVER_VERSION/webapps/geoserver/WEB-INF/lib/
RUN rm $GEOSERVER_HOME/geoserver-$GEOSERVER_VERSION-printing-plugin.zip

# Define Geoserver env
ENV GEOSERVER_HOME=$GEOSERVER_HOME/geoserver-$GEOSERVER_VERSION
WORKDIR $GEOSERVER_HOME/bin

# Expose GeoServer's default port
EXPOSE 8080
