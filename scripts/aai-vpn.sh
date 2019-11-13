#!/bin/bash

sudo openconnect --user rumpold \
	--passwd-on-stdin \
	--protocol gp \
	--verbose \
	--script=/usr/local/bin/vpnc-script \
	--servercert pin-sha256:lB/2vmLRPBhyGPv56CeveBmbAyRU/7+OSTtGISg2JtA= \
	vpn01.appliedai.de < <(secret-tool lookup service 'aAI VPN')

