FROM jetbrains/teamcity-agent:latest

RUN apt-get update \
 && apt-get install -y openvpn \
 && rm -rf /var/lib/apt/lists/*
 
RUN touch /etc/cron.d/ovpn-healthstatus \
 && echo "* * * * * /ovpn_healthcheck.sh" >> /etc/cron.d/ovpn-healthstatus \
 && crontab /etc/cron.d/ovpn-healthstatus \
 && touch /var/log/cron.log
 
COPY ./startup.sh .

COPY ./ovpn_healthcheck.sh .

VOLUME /etc/openvpn/client.ovpn

CMD sh ./startup.sh
