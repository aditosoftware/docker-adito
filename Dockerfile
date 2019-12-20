FROM adoptopenjdk/openjdk13:x86_64-ubuntu-jdk-13.0.1_9-slim

RUN apt update -qq \
 && apt install -qqy curl vim fontconfig wget cabextract xfonts-utils\
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" \
  | debconf-set-selections \
 && curl -O "http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb" \
 && dpkg -i ttf-mscorefonts-installer_3.6_all.deb \
 && rm -rf /var/lib/apt/lists/* ttf-mscorefonts-installer_3.6_all.deb

ENV INSTALL4J_JAVA_HOME=$JAVA_HOME

ADD ./config /a/config

RUN curl -so /tmp/adito.tar "https://static.adito.de/common/install/ADITO/ADITO_2020.0.0-TEST11_unix.tar" \
 && tar -xf /tmp/adito.tar -C /tmp/ \
 && chmod +x /tmp/install/ADITO_unix.sh \
 && /tmp/install/ADITO_unix.sh -q -varfile /a/config/response.varfile \
 && rm -rf /tmp/* /opt/ADITO/bin/ADITO*server.vmoptions \
 && ln -sf /opt/java/openjdk /opt/ADITO/jre

EXPOSE 8090 7934 7779 7778 7733 161/udp 80

WORKDIR /opt/ADITO

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh
