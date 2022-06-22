#!/bin/bash

set -xeu

GATEWAY=vpn01.aai.sh
AUTHGROUP=vpn01-le

sudo openconnect --user rumpold \
	--passwd-on-stdin \
	--protocol gp \
	--background \
	--script="/usr/bin/vpn-slice 10.0.0.0/8" \
	--authgroup=$AUTHGROUP \
	$GATEWAY < <(secret-tool lookup service 'aAI VPN')

sleep 1
K8S_MASTER=$(dig k8s.infra.aai.sh +short | head -n1)
sudo ip route add $K8S_MASTER dev tun0

GKE_INGRESS=$(dig gke-ingress.infra.aai.sh +short | head -n1)
sudo ip route add $GKE_INGRESS dev tun0
