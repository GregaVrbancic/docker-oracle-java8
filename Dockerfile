FROM phusion/baseimage
MAINTAINER Grega Vrbančič <grega.vrbancic@gmail.com>

# install wget
RUN apt-get update && apt-get install -y wget

# download java 
ENV JAVA_VERSION 1.8.0_144
ENV JAVA_DOWNLOAD http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jdk-8u144-linux-x64.tar.gz
RUN wget --no-cookies --header "Cookie: oraclelicense=accept-secure-backup-cookie" -O /tmp/jdk-8u144-linux-x64.tar.gz $JAVA_DOWNLOAD

# install java
RUN mkdir /opt/java-oracle && tar -zxf /tmp/jdk-8u144-linux-x64.tar.gz -C /opt/java-oracle/
ENV JAVA_HOME /opt/java-oracle/jdk$JAVA_VERSION
ENV PATH $JAVA_HOME/bin:$PATH
RUN update-alternatives --install /usr/bin/java java $JAVA_HOME/bin/java 20000 && update-alternatives --install /usr/bin/javac javac $JAVA_HOME/bin/javac 20000

# clean
RUN apt-get clean
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*