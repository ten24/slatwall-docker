# Slatwall Version 4.1.011
FROM lucee/lucee-tomcat:latest
MAINTAINER Greg Moser, greg.moser@ten24web.com

RUN apt-get update && apt-get install -y uuid-runtime

# Set the Slatwall download URL
ENV SLATWALL_VERSION 4.1.011
ENV SLATWALL_SOURCE_URL https://github.com/ten24/slatwall/archive/$SLATWALL_VERSION.zip

# Download Slatwall, unzip and remove Downloaded zip
RUN wget -nv $SLATWALL_SOURCE_URL -O /root/slatwall.zip && \
	unzip /root/slatwall.zip -d /root && \
	cp -a /root/slatwall-$SLATWALL_VERSION/. /var/www && \
	rm -rf /root/slatwall.zip && \
	rm -rf /root/slatwall-$SLATWALL_VERSION

# Setup Volumes
VOLUME ["/var/www/custom", "/var/www/integrationServices"]

COPY lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm

EXPOSE 8080

COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["catalina.sh", "run"]