FROM slatwall/slatwall:latest
MAINTAINER Greg Moser, greg.moser@ten24web.com

# Install Supervisor
RUN apt-get update && apt-get install -y supervisor

# Because we are running mysql and lucee we copy over a subervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Setup Mysql Volumes
VOLUME ["/var/lib/mysql"]

# Expose Mysql Ports
EXPOSE 8080 3306

# Set some defaults so that the container just runs
ENV MYSQL_HOST localhost
ENV MYSQL_DATABASE Slatwall
ENV MYSQL_ROOT_PASSWORD MakeThisSecret!
ENV LUCEE_PASSWORD AlsoChangeThis!

# Copy over the entrypoint to install the mysql server
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]
