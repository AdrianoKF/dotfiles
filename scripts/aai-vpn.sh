#!/bin/bash

sudo openconnect --user rumpold \
	--passwd-on-stdin \
	--protocol gp \
        --background \
	--script="/usr/bin/vpn-slice 10.0.0.0/8 172.0.0.0/8" \
	--servercert pin-sha256:lB/2vmLRPBhyGPv56CeveBmbAyRU/7+OSTtGISg2JtA= \
	vpn01.appliedai.de < <(secret-tool lookup service 'aAI VPN') && \
sleep 1 && \
sudo systemd-resolve --interface tun0 --set-domain aai.lab --set-dns 10.32.16.1 --set-dnssec no

