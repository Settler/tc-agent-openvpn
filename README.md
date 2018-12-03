# teamcity-agent-openvpn

Allow TeamCity Agent connect via secured VPN tunnel to TeamCity server.

Based on https://hub.docker.com/r/jetbrains/teamcity-agent/ image.

# How to Use This Image
```
docker run -it -e SERVER_URL="<url to TeamCity server>"  \
    --cap-add NET_ADMIN \
    -v <path to agent config folder>:/data/teamcity_agent/conf  \
    -v <path to client.ovpn file>:/etc/openvpn/client.ovpn  \
    settler/teamcity-agent-openvpn
```

# How to Use This Image in Kubernetes
`kubectl apply -f teamcity-agent-openvpn.yaml`

**teamcity-agent-openvpn.yaml:**
```
apiVersion: v1
kind: ConfigMap
metadata:
  name: teamcity-agent
  labels:
    app: teamcity-agent
data:
  client.ovpn: |
    ##############################################
    # Sample client-side OpenVPN 2.0 config file #
    # for connecting to multi-client server.     #
    #                                            #
    # This configuration can be used by multiple #
    # clients, however each client should have   #
    # its own cert and key files.                #
    #                                            #
    # On Windows, you might want to rename this  #
    # file so it has a .ovpn extension           #
    ##############################################

    # Here you should define your config data indented to 4 spaces

---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: teamcity-agent
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: teamcity-agent
    spec:
      containers:
      - name: teamcity-agent
        image: settler/teamcity-agent-openvpn:latest
        securityContext:
          capabilities:
            add:
              - NET_ADMIN
        env:
        - name: SERVER_URL
          value: <url to TeamCity server>
        - name: AGENT_NAME
          value: vpn_agent
        volumeMounts:
        - name: agent-conf
          mountPath: /data/teamcity_agent/conf
        - name: client-ovpn
          mountPath: /etc/openvpn/client.ovpn
          subPath: client.ovpn
          readOnly: true
        resources:
          requests:
            memory: "512Mi"
            cpu: "50m"
          limits:
            memory: "1Gi"
            cpu: "200m"
      volumes:
        - name: agent-conf
          emptyDir: {}
        - name: client-ovpn
          configMap:
            name: teamcity-agent
```
