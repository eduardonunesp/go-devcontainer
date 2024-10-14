#!/bin/bash

# Location
LANG="en_US.UTF-8"
LANGUAGE="en_US:en"
LC_ALL="en_US.UTF-8"

# Platform config
PLATFORM=linux
ARCH=arm64
GOVERSION=go1.23.2

cd /tmp
curl -L -s "https://go.dev/dl/$GOVERION.$PLATFORM-$ARCH.tar.gz" -o go.tar.gz
sudo tar -C /usr/local -xvzf go.tar.gz
rm -rf go.tar.gz

# Go env vars
export PATH=$PATH:/usr/local/go/bin
export GOPATH=$HOME/.go
export PATH=$PATH:$GOPATH/bin

# Install go required modules
go install golang.org/x/tools/gopls@latest
go install honnef.co/go/tools/cmd/staticcheck@latest

echo "OnCreate Event Finished"
