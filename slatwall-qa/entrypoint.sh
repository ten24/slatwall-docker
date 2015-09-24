#!/bin/bash

# === COPIED FROM SLATWALL-LUCEE DOCKER FILE ===

# Download Slatwall, unzip and remove Downloaded zip
wget -nv https://github.com/ten24/slatwall/archive/${SLATWALL_VERSION_OR_BRANCH}.zip -O /root/slatwall.zip && \
	unzip /root/slatwall.zip -d /root && \
	cp -a /root/slatwall-${SLATWALL_VERSION_OR_BRANCH}/. /var/www && \
	rm -rf /root/slatwall.zip && \
	rm -rf /root/slatwall-$SLATWALL_VERSION

# Copy over the configFramework.cfm file
cp /root/configFramework.cfm /var/www/custom/config/configFramework.cfm

	
# === END: COPIED FROM SLATWALL-LUCEE DOCKER FILE ===

# === COPIED FROM SLATWALL-LUCEE IMAGE ===
LUCEEPASS=${LUCEE_PASSWORD}

#LUCEESERVERSALT=$(uuidgen)
#LUCEESERVERSALT=${LUCEESERVERSALT^^}
LUCEESERVERSALT='4FDA588E-318A-445C-898736AA1F229A69'

#LUCEEWEBSALT=$(uuidgen)
#LUCEEWEBSALT=${LUCEEWEBSALT^^}
LUCEEWEBSALT='12FB74C3-69CD-4348-A839A29127ED8B7C'

LUCEESERVERPASS=$LUCEEPASS:$LUCEESERVERSALT
LUCEEWEBPASS=$LUCEEPASS:$LUCEEWEBSALT

for i in `seq 1 5`;
do
	LUCEESERVERPASS=($(echo -n $LUCEESERVERPASS | sha256sum))
	LUCEEWEBPASS=($(echo -n $LUCEEWEBPASS | sha256sum))
done

sed -i "s/\${SERVER-HSPW}/$LUCEESERVERPASS/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${SERVER-HSPW-SALT}/$LUCEESERVERSALT/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${MYSQL_ROOT_PASSWORD}/${MYSQL_ROOT_PASSWORD}/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${MYSQL_HOST}/${MYSQL_HOST}/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${WEB-HSPW}/$LUCEEWEBPASS/g" /opt/lucee/web/lucee-web.xml.cfm
sed -i "s/\${WEB-HSPW-SALT}/$LUCEEWEBSALT/g" /opt/lucee/web/lucee-web.xml.cfm
# === END: COPIED FROM SLATWALL-LUCEE IMAGE ===

debconf-set-selections <<< "mysql-server mysql-server/root_password password $MYSQL_ROOT_PASSWORD"
debconf-set-selections <<< "mysql-server mysql-server/root_password_again password $MYSQL_ROOT_PASSWORD"
apt-get -y install mysql-server

echo "CREATE DATABASE IF NOT EXISTS \`$MYSQL_DATABASE\` ;" > /mysql_init.sql

exec "$@"