# minikube-network

> https://minikube.sigs.k8s.io/docs/handbook/network_policy/
> A vanilla minikube installation (minikube start) does not support any NetworkPolicies, since the default CNI, Kindnet, does not support Network Policies, by design.

## Default network

Default pods

```
$ kubectl get pods -A
NAMESPACE     NAME                               READY   STATUS    RESTARTS      AGE
kube-system   coredns-5d78c9869d-7w8f8           1/1     Running   0             118s
kube-system   etcd-minikube                      1/1     Running   0             2m10s
kube-system   kube-apiserver-minikube            1/1     Running   0             2m10s
kube-system   kube-controller-manager-minikube   1/1     Running   0             2m10s
kube-system   kube-proxy-b8lxn                   1/1     Running   0             118s
kube-system   kube-scheduler-minikube            1/1     Running   0             2m10s
kube-system   storage-provisioner                1/1     Running   1 (87s ago)   2m9s
```

Installed containers on cluster

```
$ docker images
REPOSITORY                                TAG       IMAGE ID       CREATED         SIZE
registry.k8s.io/kube-apiserver            v1.27.5   b58f4bc39345   20 months ago   121MB
registry.k8s.io/kube-scheduler            v1.27.5   96c06904875e   20 months ago   58.4MB
registry.k8s.io/kube-controller-manager   v1.27.5   ae819fd2a0d7   20 months ago   113MB
registry.k8s.io/kube-proxy                v1.27.5   f249729a2355   20 months ago   71.1MB
registry.k8s.io/coredns/coredns           v1.10.1   ead0a4a53df8   2 years ago     53.6MB
registry.k8s.io/etcd                      3.5.7-0   86b6af7dd652   2 years ago     296MB
registry.k8s.io/pause                     3.9       e6f181688397   2 years ago     744kB
gcr.io/k8s-minikube/storage-provisioner   v5        6e38f40d628d   4 years ago     31.5MB
```

## Kindnet

https://www.tkng.io/cni/kindnet/
https://www.tkng.io/arch/

## Calico

1. Start cluster with calico.

    ```
    minikube start --cni calico
    ```

2. Pods

    ```
    ```

3. Container images

    ```
    ```

