#!/bin/bash
cp -f /a/config/ADITOserver.vmoptions /opt/ADITO/bin/ADITOserver.vmoptions
cp -f /a/config/serverconfig.xml /opt/ADITO/config/serverconfig.xml

sed -i s/{SRVCONF_DATABASE}/"${SRVCONF_DATABASE}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_DATABASETYP}/"${SRVCONF_DATABASETYP}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_HOST}/"${SRVCONF_HOST}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_PASSWORD}/"${SRVCONF_PASSWORD}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_PORT}/"${SRVCONF_PORT}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_USER}/"${SRVCONF_USER}"/g /opt/ADITO/config/serverconfig.xml
sed -i s/{SRVCONF_SERVER_ID}/"${SRVCONF_SERVER_ID}"/g /opt/ADITO/config/serverconfig.xml


sed -i s/{JVM_XMX}/"${JVM_XMX:-1G}"/g /opt/ADITO/bin/ADITOserver.vmoptions


/opt/ADITO/bin/ADITOserver