# minikube-dev

The goal of this project is to provide an isolated minikube environment - all minikube components 
are installed local to this project (minus container images / virtualbox virtual machines). 

## Quick start

1. Execute: `source bashrc`

2. Execute: `local-build`

    - Pass in the minikube version you want to install locally, ex. `v1.33.1`

3. Use a prepackaged minikube profile to start, ex. virtualbox

    - Execute: `mkdir -p .minikube/config`
    - Execute: `cp drivers/virtualbox/config/config.json .minikube/config/.`

4. Start minikube
    ````
    minikube start
    ````

5. Execute: `kubectl config view`

## Commands

### Initial Minikube configurations

```
minikube config set driver virtualbox
minikube config set WantUpdateNotification false
```

### View Minikube configurations

```
minikube config view
```

### Start the cluster

```
minikube start --profile dev1
minikube start --kubernetes-version=v1.27.5 --profile dev1 --driver=virtualbox 
```

### Get or set the profile

```
minikube profile dev1
```

### Verify entities in the current cluster / profile

```
kubectl get deployments -A
kubectl get pods -A
kubectl get nodes -A
kubectl get services -A
kubectl get namespaces -A
```

### View k8s configurations

```
kubectl config view
```

### Delete secret (i.e. dockerconfigjson)

```
kubectl delete secret kkdt --namespace default
```

### Show existing secret

```
kubectl get secret
kubectl get secret kkdt --namespace default [--output yaml]
```

### Create k8s secret

```
kubectl create secret generic kkdt \
  --from-file=.dockerconfigjson=$HOME/.docker/config.json \
  --type=kubernetes.io/dockerconfigjson \
  --cluster dev1 \
  --namespace default
```

### Get a shell to running container

```
kubectl exec --stdin --tty grafana -- /bin/bash
```

### Mounts

https://minikube.sigs.k8s.io/docs/handbook/mount/

On the minikube virtual machine, `/hosthome` mounts the user HOME directory.

```
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
tmpfs           3.2G  806M  2.4G  25% /
devtmpfs        1.7G     0  1.7G   0% /dev
tmpfs           1.8G   84K  1.8G   1% /dev/shm
tmpfs           726M   11M  715M   2% /run
tmpfs           1.8G  8.0K  1.8G   1% /tmp
/dev/sda1        17G  1.1G   15G   7% /mnt/sda1
hosthome        160G  8.1G  151G   6% /hosthome

$ ls /hosthome/
thinh
```

### Physical volumes

https://minikube.sigs.k8s.io/docs/handbook/persistent_volumes/

```
kubectl get pv -A
kubectl create -f resources/pv0001.yml
```


[//]: Links

[hello-minikube]: https://kubernetes.io/docs/tutorials/hello-minikube/
[k8s-pull-image-private-registry]: https://kubernetes.io/docs/tasks/configure-pod-container/pull-image-private-registry/
[k8s-nfs]: https://github.com/appscode/third-party-tools/blob/master/storage/nfs/README.md
[minikube-release]: https://github.com/kubernetes/minikube/releases/tag/v1.33.1
[minikube-kicbase]: https://github.com/kubernetes/minikube/pkgs/container/minikube%2Fkicbase