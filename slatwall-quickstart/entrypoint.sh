#!/bin/bash

# Clear out the www folder
rm -rf /var/www/*

# Download Slatwall, unzip and remove Downloaded zip
wget -nv https://github.com/ten24/slatwall/archive/master.zip -O /root/slatwall.zip && \
	unzip /root/slatwall.zip -d /root && \
	cp -a /root/slatwall-master/. /var/www && \
	rm -rf /root/slatwall.zip && \
	rm -rf /root/slatwall-master

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

catalina.sh run

exec "$@"
