# kubernetes-kind

Docs: https://kind.sigs.k8s.io/docs/user/quick-start/

## Setup Kind, Kubectl and the cluster

```bash
chmod +x ./setup.sh && chmod +x ./recreate-cluster.sh && ./setup.sh
```

## Manually launch the cluster
```bash
kind create cluster --config ./kind-cluster-3master-3workers.yml --image kindest/node:$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
```

## Delete the cluster

```bash
kind delete cluster
```

## Create the secret

```bash
cp deployments/github-registry-secret-template.yml deployments/github-registry-secret.yml
```

```bash
echo -n "YOUR_USER:YOUR_GH_TOKEN" | base64
```

**Replace BASE_64_SECRET with the base64 string from the first command**
```bash
echo -n  '{"auths":{"ghcr.io":{"auth":"BASE_64_SECRET"}}}' | base64
```

**Copy the base 64 token and replace <BASE64> in the github-registry-secret.yml**


## Deployments

### ghcr.io deploy

```bash
kubectl apply -f deployments/github-registry-secret.yml
```

## deploy the server

```bash
kubectl apply -f deployments/server-pod.yml
```

## Network Policies (Calico)

### Enable Isolation (on default namespace)

```bash
kubectl create -n default -f deployments/default-deny.yaml
```

### Create the server network policy to allow traffic from the client to the server

```bash
kubectl create -f deployments/server-policy.yaml
```
# kind-cluster
