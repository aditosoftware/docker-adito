FROM ubuntu:18.04

RUN apt update -qq \
 && apt install -qqy curl vim fontconfig wget cabextract xfonts-utils\
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" \
  | debconf-set-selections \
 && curl -O "http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb" \
 && dpkg -i ttf-mscorefonts-installer_3.6_all.deb \
 && rm -rf /var/lib/apt/lists/* ttf-mscorefonts-installer_3.6_all.deb

RUN curl -sLH "Cookie: oraclelicense=accept-securebackup-cookie" \
    "http://download.oracle.com/otn-pub/java/jdk/8u191-b12/2787e4a523244c269598db4e85c51e0c/jre-8u191-linux-x64.tar.gz" \
  | tar -xzf - -C /opt \
 && mv /opt/jre1.8* /opt/jre

ENV INSTALL4J_JAVA_HOME='/opt/jre' \
    LANG='C.UTF-8' \
    LC_ALL='C.UTF-8' \
    LANGUAGE='C.UTF-8'

ADD ./config /a/config

RUN curl -so /tmp/adito.tar "http://static.adito.de/common/install/ADITO5/ADITO_5.1.181113_unix.tar" \
 && tar -xf /tmp/adito.tar -C /tmp/ \
 && chmod +x /tmp/install/ADITO_unix.sh \
 && /tmp/install/ADITO_unix.sh -q -varfile /a/config/response.varfile \
 && rm -rf /tmp/* /opt/ADITO/bin/ADITO*server.vmoptions \
 && mv /opt/ADITO/bin/ADITO*server /opt/ADITO/bin/ADITOserver

EXPOSE 8090 7934 7779 7778 7733 161/udp 80

WORKDIR /opt/ADITO

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh
