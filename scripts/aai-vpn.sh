#!/bin/bash

set -xeu

# sudo openconnect --user rumpold \
# 	--passwd-on-stdin \
# 	--protocol gp \
#         --background \
# 	--script="/usr/bin/vpn-slice 10.0.0.0/8 172.20.0.0/16" \
# 	--servercert pin-sha256:lB/2vmLRPBhyGPv56CeveBmbAyRU/7+OSTtGISg2JtA= \
# 	vpn01.appliedai.de < <(secret-tool lookup service 'aAI VPN') && \
# sudo openconnect --user rumpold \
# 	--passwd-on-stdin \
#         --protocol gp \
#         --background \
#         --authgroup=vpn01-le \
# 	--script="/usr/bin/vpn-slice 10.0.0.0/8" \
# 	--servercert pin-sha256:vyJLuE3cdK+VXrlhe+B9pBny+3gnFn8TPEGWuEuSpyU= \
# 	vpn01.aai.sh < <(secret-tool lookup service 'aAI VPN') && \
sudo openconnect --user rumpold \
	--passwd-on-stdin \
	--protocol gp \
	--background \
	--script="/usr/bin/vpn-slice 10.0.0.0/8" \
	--servercert pin-sha256:CJUmSp3ZEjp23xgtMIToaZJDGr4xO8b89YYRVSbfjHw= \
	vpn02.aai.sh < <(secret-tool lookup service 'aAI VPN')

K8S_MASTER=$(dig k8s.infra.aai.sh +short | head -n1)
sudo ip route add $K8S_MASTER dev tun0
