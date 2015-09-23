#!/bin/bash

LUCEEPASS=${LUCEE_PASSWORD}

#LUCEESERVERSALT=$(uuidgen)
#LUCEESERVERSALT=${LUCEESERVERSALT^^}
LUCEESERVERSALT='4FDA588E-318A-445C-898736AA1F229A69'

#LUCEEWEBSALT=$(uuidgen)
#LUCEEWEBSALT=${LUCEEWEBSALT^^}
LUCEEWEBSALT='12FB74C3-69CD-4348-A839A29127ED8B7C'

LUCEESERVERPASS=$LUCEEPASS:$LUCEESERVERSALT
LUCEEWEBPASS=$LUCEEPASS:$LUCEEWEBSALT

echo 'RAW PASS'
echo $LUCEESERVERPASS
echo $LUCEEWEBPASS

for i in `seq 1 5`;
do
	LUCEESERVERPASS=($(echo -n $LUCEESERVERPASS | sha256sum))
	LUCEEWEBPASS=($(echo -n $LUCEEWEBPASS | sha256sum))
done

echo ==== LUCEE SERVER PASSWORD ====
echo $LUCEESERVERPASS
echo $LUCEESERVERSALT
echo ==== LUCEE WEB PASSWORD ====
echo $LUCEEWEBPASS
echo $LUCEEWEBSALT

sed -i "s/\${SERVER-HSPW}/$LUCEESERVERPASS/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${SERVER-HSPW-SALT}/$LUCEESERVERSALT/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${MYSQL_ROOT_PASSWORD}/${MYSQL_ROOT_PASSWORD}/g" /opt/lucee/server/lucee-server/context/lucee-server.xml
sed -i "s/\${WEB-HSPW}/$LUCEEWEBPASS/g" /opt/lucee/web/lucee-web.xml.cfm
sed -i "s/\${WEB-HSPW-SALT}/$LUCEEWEBSALT/g" /opt/lucee/web/lucee-web.xml.cfm

cat /opt/lucee/server/lucee-server/context/lucee-server.xml
cat /opt/lucee/web/lucee-web.xml.cfm

exec "$@"