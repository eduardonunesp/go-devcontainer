#!/bin/bash

# Location
LANG="en_US.UTF-8"
LANGUAGE="en_US:en"
LC_ALL="en_US.UTF-8"

# Platform config
PLATFORM=linux
ARCH=$(uname -m)
GOVERSION=go1.23.2

if [[ "$ARCH" == x86_64* ]]; then
    ARCH="amd64"
elif [[ "$ARCH" == i*86 ]]; then
    ARCH="386"
elif [[ "$ARCH" == arm* ]]; then
    ARCH="arm"
elif [[ "$ARCH" == aarch64 ]]; then
    ARCH="arm64"
fi

URL="https://go.dev/dl/$GOVERSION.$PLATFORM-$ARCH.tar.gz"

cd /tmp
curl -L -s $URL -o go.tar.gz
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
