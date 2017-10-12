FROM ubuntu:16.04

RUN echo "deb http://archive.ubuntu.com/ubuntu/ xenial multiverse" >> /etc/apt/sources.list \
 && apt-get update -qq \
 && apt-get install -qqy curl fontconfig wget cabextract xfonts-utils\
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" \
  | debconf-set-selections \
 && curl -O "http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb" \
 && dpkg -i ttf-mscorefonts-installer_3.6_all.deb \
 && rm -rf /var/lib/apt/lists/* ttf-mscorefonts-installer_3.6_all.deb

RUN curl -sLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    http://download.oracle.com/otn-pub/java/jdk/8u144-b01/090f390dda5b47b9b721c7dfaa008135/jre-8u144-linux-x64.tar.gz \
    | tar -xzf - -C /opt \
 && mv /opt/jre1.8* /opt/jre

ENV INSTALL4J_JAVA_HOME='/opt/jre' \
    LANG='C.UTF-8' \
    LC_ALL='C.UTF-8' \
    LANGUAGE='C.UTF-8'

ADD ./config /a/config

RUN curl -o /tmp/adito.sh "http://static.adito.de/common/install/ADITO5_5.0.90-RC7_unix.sh" \
 && chmod u+x /tmp/adito.sh \
 && /tmp/adito.sh -q -varfile /a/config/response.varfile \
 && rm -rf /tmp/* /opt/ADITO/bin/StartDerby* /opt/ADITO/bin/service /opt/ADITO/bin/ADITO5server.vmoptions /opt/ADITO/uninstall \
 && mv /opt/ADITO/bin/ADITO*server /opt/ADITO/bin/ADITOserver

EXPOSE 7934 7779 7778 7733 161/udp 80

WORKDIR /opt/ADITO

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh
