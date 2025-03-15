# minikube-dev

The goal of this project is to provide an isolated minikube environment - all minikube components 
are installed local to this project (minus container images). 

## Quick start

1. Execute: `source bashrc`

2. Execute: `local-build`
    - Pass in the minikube version you want to install locally, ex. `v1.33.1`

3. Start minikube
    ````
    minikube start --profile dev1 --driver=virtualbox --kubernetes-version=v1.27.5
    ````

## Commands

minikube profile dev1
minikube start -p dev1
kubectl get pods -A 

minikube config set driver virtualbox
minikube start --profile dev1 --driver=virtualbox --kubernetes-version=v1.27.5