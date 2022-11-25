#! /bin/bash
# This script will initialise the k8s cluster using Crossplane
# Should be run only if the cluster doesn't exist yet

set -eo pipefail

kind create cluster --name=init-cluster --image kindest/node:v1.23.0 --wait 5m

# Creating Crossplane namespace
kubectl create namespace crossplane-system

# Adding Crossplane repo
helm repo add crossplane-stable https://charts.crossplane.io/stable
helm repo update

# Installing Crossplane to local cluster
helm install crossplane --namespace crossplane-system crossplane-stable/crossplane

# Installing Crossplane CLI for kubectl
curl -sL https://raw.githubusercontent.com/crossplane/crossplane/master/install.sh | sh

rm kubectl-crossplane