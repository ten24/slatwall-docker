FROM slatwall/slatwall-lucee:latest
MAINTAINER Greg Moser, greg.moser@ten24web.com

# Install Supervisor
RUN apt-get update && apt-get install -y supervisor

# Because we are running mysql and lucee we copy over a subervisord config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy over the entrypoint to install the mysql server
COPY entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

CMD ["/usr/bin/supervisord"]