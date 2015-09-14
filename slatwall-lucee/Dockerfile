# Slatwall Version 4.1.010
FROM lucee/lucee-tomcat:latest
MAINTAINER Greg Moser, greg.moser@ten24web.com

# Set the Slatwall download URL
ENV SLATWALL_VERSION 4.1.010
ENV SLATWALL_SOURCE_URL https://github.com/ten24/slatwall/archive/$SLATWALL_VERSION.zip

# Download Slatwall, unzip and remove Downloaded zip
RUN wget -nv $SLATWALL_SOURCE_URL -O /root/slatwall.zip && \
	unzip /root/slatwall.zip -d /root && \
	cp -a /root/slatwall-$SLATWALL_VERSION/. /var/www && \
	rm -rf /root/slatwall.zip && \
	rm -rf /root/slatwall-$SLATWALL_VERSION

# Setup Volumes
VOLUME ["/var/www/custom", "/var/www/integrationServices"]

EXPOSE 8080