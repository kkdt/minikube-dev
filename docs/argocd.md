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




[//]: Links

[argocd-build-environment]: https://argo-cd.readthedocs.io/en/stable/user-guide/build-environment/
[argocd-environment-variables]: https://argo-cd.readthedocs.io/en/stable/user-guide/environment-variables/