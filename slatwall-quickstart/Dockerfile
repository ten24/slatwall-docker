# Slatwall Quickstart
FROM lucee/lucee4:latest
MAINTAINER Sumit Verma, sumit.verma@ten24web.com

# Install Supervisor
RUN apt-get update && apt-get install -y

# Copy over the Lucee Configs
COPY lucee-server.xml /opt/lucee/server/lucee-server/context/lucee-server.xml
COPY lucee-web.xml.cfm /opt/lucee/web/lucee-web.xml.cfm

# Copy over the entrypoint
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

# Expose Lucee Port
EXPOSE 8888

