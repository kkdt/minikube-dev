# minikube-dev

The goal of this project is to provide an isolated minikube environment - all minikube components 
are installed local to this project (minus container images). 

## Quick start

1. Execute: `source bashrc`

2. Execute: `local-build`

    - Pass in the minikube version you want to install locally, ex. `v1.33.1`

3. Start minikube
    ````
    minikube start --driver=virtualbox --kubernetes-version=v1.27.5
    ````

## Commands

### Initial Minikube configurations

minikube config set driver virtualbox
minikube config set WantUpdateNotification false

### View Minikube configurations

minikube config view

### Start the cluster

minkube start --profile dev1
minikube start --driver=virtualbox --kubernetes-version=v1.27.5 --profile dev1

### Get or set the profile

minikube profile dev1

### Get pods in the current cluster / profile

kubectl get pods -A

### View k8s configurations

kubectl config view

### Delete secret (i.e. dockerconfigjson)

kubectl delete secret kkdt --namespace home

### Show existing secret

kubectl get secret

kubectl get secret kkdt --namespace home [--output yaml]

### Create k8s secret

kubectl create secret generic kkdt \
  --from-file $HOME/.docker/config.json \
  --type kubernetes.io/dockerconfigjson \
  --cluster dev1 \
  --namespace home

### Get a shell to running container

kubectl exec --stdin --tty grafana -- /bin/bash


[//]: Links

[k8s-pull-image-private-registry]: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/