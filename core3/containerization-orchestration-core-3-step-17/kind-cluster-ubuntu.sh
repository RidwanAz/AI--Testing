#!/bin/bash

# Download and install kubectl
sudo curl -L "https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl" -o /usr/local/bin/kubectl 

# Make the app executable:
sudo chmod +x /usr/local/bin/kubectl 

# Download and install KinD
sudo curl -L "https://kind.sigs.k8s.io/dl/v0.20.0/kind-$(uname)-amd64" -o /usr/local/bin/kind

# Make the app executable:
$ sudo chmod +x /usr/local/bin/kind 

# Test the installation:
kind get clusters 

#If kind was installed correctly, you should see the following output:No kind clusters found. 
# If you got to this point, CONGRATULATIONS!

# Create the KinD configuration file kind-config
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 80
    protocol: TCP
  - containerPort: 443
    hostPort: 443
    protocol: TCP
- role: worker

# Start your KinD cluster with:
kind create cluster --name=one-master-one-node-cluster --config=kind-config
kind create cluster --name=one-master-one-node-cluster --config=kind-config

kubectl cluster-info --context kind-one-master-one-node-cluster

# verify this with kubectl:
kubectl get nodes

# Install Helm
curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
sudo apt-get install apt-transport-https --yes
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm

# install nginx ingress in kubernetes
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/kind/deploy.yaml

kubectl get all --all-namespaces