# tc-agent-openvpn

Allow TeamCity Agent connect via secured VPN tunnel to TeamCity server.

Based on https://hub.docker.com/r/jetbrains/teamcity-agent/ image.

How to Use This Image
=================
    docker run -it -e SERVER_URL="<url to TeamCity server>"  \ 
        -v <path to agent config folder>:/data/teamcity_agent/conf  \
        -v <path to client.ovpn file>:/etc/openvpn/client.ovpn  \
        settler/teamcity-agent-openvpn
