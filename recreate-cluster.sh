#!/bin/bash

# Reset
Color_Off='\033[0m'       # Text Reset

# Colors
Green='\033[0;32m'
BGreen='\033[1;32m'       # Green

echo -e "${BGreen}Removing kind cluster...${Color_Off}"
kind delete cluster
echo -e "${BGreen}Successfully removed kind cluster!${Color_Off}"

echo -e "${BGreen}Creating cluster with 3 workers and 3 masters...${Color_Off}"
kind create cluster --config ./kind-cluster-3master-3workers.yml --image kindest/node:v1.20.0

echo -e "${BGreen}Cluster health:${Color_Off}"
kubectl cluster-info --context kind-kind

echo -e "${BGreen}Created nodes:${Color_Off}"
kubectl get nodes


echo -e "${BGreen}Installing ingress-nginx...${Color_Off}"
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml
echo -e "${BGreen}Successfully installed ingress-nginx!${Color_Off}"

echo -e "${BGreen}Waiting  ingress-nginx!${Color_Off}"
kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

echo -e "${BGreen}Installing Calico...${Color_Off}"
kubectl apply -f https://docs.projectcalico.org/v3.8/manifests/calico.yaml
kubectl -n kube-system set env daemonset/calico-node FELIX_IGNORELOOSERPF=true
echo -e "${BGreen}Successfully Calico!${Color_Off}"
