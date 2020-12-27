#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Colors
Green='\033[0;32m'
BGreen='\033[1;32m'       # Green

echo -e "${BGreen}Installing kind...${Color_Off}"

curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.9.0/kind-linux-amd64
chmod +x ./kind

sudo mv ./kind /usr/local/bin/

kind --version

echo -e "${BGreen}Successfully kind!${Color_Off}"

echo -e "${BGreen}Installing kubectl...${Color_Off}"

curl -LO "https://storage.googleapis.com/kubernetes-release/release/$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x ./kubectl

sudo mv ./kubectl /usr/local/bin/

kubectl version --client

echo -e "${BGreen}Successfully installed kubectl!${Color_Off}"

sh $(dirname ${0})/recreate-cluster.sh

