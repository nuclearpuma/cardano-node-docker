from prom/prometheus:latest
LABEL maintainer="dro@arrakis.it"

ADD config.tmpl.yml /config.tmpl.yml
ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN mkdir /config/

ENTRYPOINT ["/entrypoint.sh"]
