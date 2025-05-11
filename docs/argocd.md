# argocd

## Quick Start

1. Start up Minikube

2. Create namespace for argocd

    ```
    kubectl create namespace argocd
    ```

3. Install argocd using provided deployment file

    ```
    kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
    ```

4. Watch the deployment

    ```
    watch minikube kubectl -- get pods -A
    ```

5. Expose the argocd server

    ```
    kubectl port-forward svc/argocd-server -n argocd 8080:443
    ```

6. Retrieve the initial admin password for the argcd-server

    ```
    kubectl get pods -n argocd -l app.kubernetes.io/name=argocd-server -o name | cut -d'/' -f 2
    ```

7. Log into the argocd-server on the browser: http://localhost:8080
    - Log in as `admin` using the password from Step 6 above

## Containers for argocd

Containers on cluster before argocd deployment

```
gcr.io/k8s-minikube/storage-provisioner   v5        6e38f40d628d   4 years ago     31.5MB
registry.k8s.io/coredns/coredns           v1.10.1   ead0a4a53df8   2 years ago     53.6MB
registry.k8s.io/etcd                      3.5.7-0   86b6af7dd652   2 years ago     296MB
registry.k8s.io/kube-apiserver            v1.27.5   b58f4bc39345   20 months ago   121MB
registry.k8s.io/kube-controller-manager   v1.27.5   ae819fd2a0d7   20 months ago   113MB
registry.k8s.io/kube-proxy                v1.27.5   f249729a2355   20 months ago   71.1MB
registry.k8s.io/kube-scheduler            v1.27.5   96c06904875e   20 months ago   58.4MB
registry.k8s.io/pause                     3.9       e6f181688397   2 years ago     744kB
```

Containers on clusters after argcd deployment

```
gcr.io/k8s-minikube/storage-provisioner   v5             6e38f40d628d   4 years ago     31.5MB
ghcr.io/dexidp/dex                        v2.41.1        8ff1b28fdd56   9 months ago    115MB
quay.io/argoproj/argocd                   v3.0.0         9080b96ccad3   5 days ago      506MB
redis                                     7.2.7-alpine   04bec005426e   4 months ago    40.9MB
registry.k8s.io/coredns/coredns           v1.10.1        ead0a4a53df8   2 years ago     53.6MB
registry.k8s.io/etcd                      3.5.7-0        86b6af7dd652   2 years ago     296MB
registry.k8s.io/kube-apiserver            v1.27.5        b58f4bc39345   20 months ago   121MB
registry.k8s.io/kube-controller-manager   v1.27.5        ae819fd2a0d7   20 months ago   113MB
registry.k8s.io/kube-proxy                v1.27.5        f249729a2355   20 months ago   71.1MB
registry.k8s.io/kube-scheduler            v1.27.5        96c06904875e   20 months ago   58.4MB
registry.k8s.io/pause                     3.9            e6f181688397   2 years ago     744kB
```

## List clusters

https://argo-cd.readthedocs.io/en/stable/user-guide/commands/argocd_cluster_list/

## Register a cluster to deploy apps

The commands below will install a ServiceAccount (argocd-manager), into the kube-system namespace of that kubectl context, and binds 
the service account to an admin-level ClusterRole. Argo CD uses this service account token to perform its management tasks (i.e. deploy/monitoring).

1. Determine cluster name

    ```
    kubectl config get-contexts -o name
    ```

2. Add cluster

    ```
    argocd cluster add dev1
    ```

## Private Git repositories / SSH keys

```
argocd repo add git@github.com:argoproj/argocd-example-apps.git --ssh-private-key-path ~/.ssh/id_rsa
```


[//]: Links

[argocd-build-environment]: https://argo-cd.readthedocs.io/en/stable/user-guide/build-environment/
[argocd-environment-variables]: https://argo-cd.readthedocs.io/en/stable/user-guide/environment-variables/