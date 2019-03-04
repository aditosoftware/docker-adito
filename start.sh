#!/bin/bash
cp -f /a/config/ADITOserver.vmoptions /opt/ADITO/bin/ADITOserver.vmoptions
cp -f /a/config/serverconfig.xml /opt/ADITO/config/serverconfig.xml

cp -f /opt/ADITO/webroot/webstart/config/template_client.jnlp /opt/ADITO/webroot/webstart/config/client.jnlp


sed -i s^http://host^"${WEBSTART_URL:-"http://${WEBSTART_HOST}"}"^g /opt/ADITO/webroot/webstart/config/client.jnlp
sed -i s^'<argument>host</argument>'^'<argument>'"${WEBSTART_HOST}"'</argument>'^g /opt/ADITO/webroot/webstart/config/client.jnlp
sed -i s^7779^"${ADITO_PORT:-7779}"^g /opt/ADITO/webroot/webstart/config/client.jnlp

sed -i s^CLASSIC^"${ADITO_CONNECTION_TYPE:-"NETTY"}"^g /opt/ADITO/webroot/webstart/config/client.jnlp
sed -i s^NETTY^"${ADITO_CONNECTION_TYPE:-"NETTY"}"^g /opt/ADITO/webroot/webstart/config/client.jnlp

sed -i s/{SRVCONF_DATABASE}/"${SRVCONF_DATABASE}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_DATABASETYP}/"${SRVCONF_DATABASETYP}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_HOST}/"${SRVCONF_HOST}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_PASSWORD}/"${SRVCONF_PASSWORD}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_PORT}/"${SRVCONF_PORT}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_USER}/"${SRVCONF_USER}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_SERVER_ID}/"${SRVCONF_SERVER_ID}"/g /opt/ADITO/config/serverconfig.xml


sed -i s/{JVM_XMX}/"${JVM_XMX:-1024M}"/g /opt/ADITO/bin/ADITOserver.vmoptions

/opt/ADITO/bin/ADITOserver