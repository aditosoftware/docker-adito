FROM adoptopenjdk/openjdk13:x86_64-ubuntu-jdk-13.0.2_8-slim

RUN apt update -qq \
 && apt install -qqy curl vim fontconfig wget cabextract xfonts-utils\
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" \
  | debconf-set-selections \
 && curl -O "http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb" \
 && dpkg -i ttf-mscorefonts-installer_3.6_all.deb \
 && rm -rf /var/lib/apt/lists/* ttf-mscorefonts-installer_3.6_all.deb

ENV INSTALL4J_JAVA_HOME=$JAVA_HOME

ADD ./config /a/config

RUN curl -so /tmp/adito.tar "https://static.adito.de/common/install/ADITO/ADITO_2022.0.3.1_unix.tar" \
 && tar -xf /tmp/adito.tar -C /tmp/ \
 && chmod +x /tmp/install/ADITO_unix.sh \
 && /tmp/install/ADITO_unix.sh -q -varfile /a/config/response.varfile \
 && rm -rf /opt/ADITO/webroot/webstart/lib/client \
 && mv -f /opt/ADITO/lib/client /opt/ADITO/webroot/webstart/lib \
 && rm -rf /tmp/* /opt/ADITO/bin/ADITO*server.vmoptions \
 && ln -sf /opt/java/openjdk /opt/ADITO/jre

EXPOSE 8080 8443

WORKDIR /opt/ADITO

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh
