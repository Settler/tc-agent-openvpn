FROM jetbrains/teamcity-agent:latest

RUN apt-get update \
 && apt-get install -y openvpn \
 && rm -rf /var/lib/apt/lists/*
 
COPY ./startup.sh .

VOLUME /etc/openvpn/client.ovpn

CMD sh ./startup.sh
