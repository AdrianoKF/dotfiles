#!/bin/bash

set -xeu

GATEWAY=vpn01.aai.sh
AUTHGROUP=vpn01-le

# GATEWAY=vpn02.aai.sh
# CERT_FINGERPRINT="pin-sha256:QNKZ7jW3JXZCqtvjFDhJoBwm60ZQ3OA28dBuPRpHzAU="
CERT_FINGERPRINT="pin-sha256:qKXYOg+Tb/8tbWvBS/lQuY/6RUB5OUUGYgmdiBoMrKk="
#CERT_FINGERPRINT="pin-sha256:+9ZWopAZddZv+scPlYA+qpcAdNJcm8GdMtV5NlRbEjc="

# sudo openconnect --user rumpold \
# 	--passwd-on-stdin \
# 	--protocol gp \
#         --background \
# 	--script="/usr/bin/vpn-slice 10.0.0.0/8 172.20.0.0/16" \
# 	--servercert pin-sha256:lB/2vmLRPBhyGPv56CeveBmbAyRU/7+OSTtGISg2JtA= \
# 	vpn01.appliedai.de < <(secret-tool lookup service 'aAI VPN') && \
#sudo openconnect --user rumpold \
#	--passwd-on-stdin \
#        --protocol gp \
#        --background \
#        --authgroup=vpn01-le \
#	--script="/usr/bin/vpn-slice 10.0.0.0/8" \
#	--servercert pin-sha256:+9ZWopAZddZv+scPlYA+qpcAdNJcm8GdMtV5NlRbEjc= \
#	vpn01.aai.sh < <(secret-tool lookup service 'aAI VPN') && \
sudo openconnect --user rumpold \
	--passwd-on-stdin \
	--protocol gp \
	--background \
	--script="/usr/bin/vpn-slice 10.0.0.0/8" \
	--authgroup=$AUTHGROUP \
	--servercert $CERT_FINGERPRINT \
	$GATEWAY < <(secret-tool lookup service 'aAI VPN')

sleep 1
K8S_MASTER=$(dig k8s.infra.aai.sh +short | head -n1)
sudo ip route add $K8S_MASTER dev tun0

GKE_INGRESS=$(dig gke-ingress.infra.aai.sh +short | head -n1)
sudo ip route add $GKE_INGRESS dev tun0
