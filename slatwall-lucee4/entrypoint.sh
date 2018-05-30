#!/bin/bash
LUCEEPASS=${LUCEE_PASSWORD}
LUCEESERVERSALT='4FDA588E-318A-445C-898736AA1F229A69'
LUCEEWEBSALT='12FB74C3-69CD-4348-A839A29127ED8B7C'

LUCEESERVERPASS=$LUCEEPASS:$LUCEESERVERSALT
LUCEEWEBPASS=$LUCEEPASS:$LUCEEWEBSALT

for i in `seq 1 5`;
do
	LUCEESERVERPASS=($(echo -n $LUCEESERVERPASS | sha256sum))
	LUCEEWEBPASS=($(echo -n $LUCEEWEBPASS | sha256sum))
done

# update Slatwall
if [ "$UPDATE" == "true" ]; then
	wget -nv https://github.com/ten24/slatwall/archive/${BRANCH}.zip -O /root/slatwall.zip && \
		unzip /root/slatwall.zip -d /root/slatwall && \
		cp -a /root/slatwall/slatwall-${BRANCH}/. /var/www && \
		rm -rf /root/slatwall.zip && \
		rm -rf /root/slatwall
fi

# Copy over the configFramework.cfm file so that it displays full errors
cp /root/configFramework.cfm /var/www/custom/config/configFramework.cfm

##### UPDATE LUCEE CONFIG FILES #####
# Update Lucee Server Admin Password
sed -i "s/\${SERVER-HSPW}/$LUCEESERVERPASS/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${SERVER-HSPW-SALT}/$LUCEESERVERSALT/g" /opt/lucee/server/lucee-server/context/lucee-server.xml

# Update Lucee Datasource Information
sed -i "s/\${MYSQL_ROOT_PASSWORD}/${MYSQL_ROOT_PASSWORD}/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${MYSQL_HOST}/${MYSQL_HOST}/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${MYSQL_DATABASE}/${MYSQL_DATABASE}/g" /opt/lucee/server/lucee-server/context/lucee-server.xml

# Update Lucee Web Admin Password
sed -i "s/\${WEB-HSPW}/$LUCEEWEBPASS/g" /opt/lucee/web/lucee-web.xml.cfm
sed -i "s/\${WEB-HSPW-SALT}/$LUCEEWEBSALT/g" /opt/lucee/web/lucee-web.xml.cfm

exec "$@"
