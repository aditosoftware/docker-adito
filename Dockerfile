FROM ubuntu:18.04

RUN apt update -qq \
 && apt install -qqy curl vim fontconfig wget cabextract xfonts-utils\
 && echo "ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula boolean true" \
  | debconf-set-selections \
 && curl -O "http://ftp.de.debian.org/debian/pool/contrib/m/msttcorefonts/ttf-mscorefonts-installer_3.6_all.deb" \
 && dpkg -i ttf-mscorefonts-installer_3.6_all.deb \
 && rm -rf /var/lib/apt/lists/* ttf-mscorefonts-installer_3.6_all.deb

RUN curl -s "https://static.adito.de/jre/jre-10.0.2_linux-x64_bin.tar.gz" \
  | tar -xzf - -C /opt \
 && mv /opt/jre* /opt/jre

ENV INSTALL4J_JAVA_HOME='/opt/jre' \
    LANG='C.UTF-8' \
    LC_ALL='C.UTF-8' \
    LANGUAGE='C.UTF-8'

ADD ./config /a/config

RUN curl -so /tmp/adito.tar "https://static.adito.de/common/install/ADITO/ADITO_2019.3.0-RC11_unix.tar" \
 && tar -xf /tmp/adito.tar -C /tmp/ \
 && chmod +x /tmp/install/ADITO_unix.sh \
 && /tmp/install/ADITO_unix.sh -q -varfile /a/config/response.varfile \
 && rm -rf /tmp/* /opt/ADITO/bin/ADITO*server.vmoptions \
 && ln -sf /opt/jre /opt/ADITO/jre

EXPOSE 8090 7934 7779 7778 7733 161/udp 80

ENV INSTALL4J_JAVA_HOME='/opt/jre'

WORKDIR /opt/ADITO

ADD ./start.sh /a/start.sh
RUN chmod u+x /a/start.sh
CMD /a/start.sh
