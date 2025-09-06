#!/bin/bash

__directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

localclean() {
  read -p "Confirm .minikbue and .kube and .helm deletes, hit ENTER to continue or CTRL-C to exit"
  rm -rf ${__directory}/build
}

localbuild() {
  local __dist=${__directory}/build
  local __bin=${__directory}/build/bin

  mkdir -p ${__bin}
  mkdir -p ${__dist}/.minikube/config
  mkdir -p ${__dist}/.kube
  mkdir -p ${__dist}/.helm

  local __default_minikube="https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
  local __default_argocd="https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64"
  local __default_helm="https://get.helm.sh/helm-v3.19.0-rc.1-linux-amd64.tar.gz"

  if [ ! -z "${1}" ]; then
    __default_minikube="https://storage.googleapis.com/minikube/releases/${1}/minikube-linux-amd64"
  fi

  wget -O ${__directory}/build/minikube-binary ${__default_minikube}
  if [ $? -ne 0 ]; then
    return 1
  fi
  install ${__directory}/build/minikube-binary ${__bin}/minikube && rm -f ${__directory}/build/minikube-binary

  wget -O ${__directory}/build/argocd-binary ${__default_argocd}
  if [ $? -ne 0 ]; then
    return 1
  fi
  install ${__directory}/build/argocd-binary ${__bin}/argocd && rm -f ${__directory}/build/argocd-binary

  wget -O ${__directory}/build/helm.tar.gz ${__default_helm}
  if [ $? -ne 0 ]; then
    return 1
  fi
  tar xvf ${__directory}/build/helm.tar.gz -C ${__directory}/build/ \
    && mv ${__directory}/build/linux-amd64/helm ${__bin}/helm \
    && rm -f ${__directory}/build/helm.tar.gz \
    && rm -rf ${__directory}/build/linux-amd64
}

#---------------------------------------------------------------
# Environment
#---------------------------------------------------------------

export PATH=${__directory}/build/bin:$PATH

export KUBECONFIG=${__directory}/build/.kube/config

export KUBECACHEDIR=${__directory}/build/.kube/cache

# No emoji icons
export MINIKUBE_IN_STYLE=0

# Manually set to this project; otherwise, default is ~/.minikube
export MINIKUBE_HOME=${__directory}/build/.minikube

# Automatically change ownership of ~/.minikube to the value of $SUDO_USER 
export CHANGE_MINIKUBE_NONE_USER=true

# Enable/disable trace profiling to be generated for minikube
export MINIKUBE_ENABLE_PROFILING=0

# Suppresses Docker performance warnings when Docker is slow
export MINIKUBE_SUPPRESS_DOCKER_PERFORMANCE=true

export HELM_HOME=${__directory}/build/.helm
export HELM_REPOSITORY_CACHE=${HELM_HOME}/cache
export HELM_PLUGIN_DIR=${HELM_HOME}/plugins
export HELM_NAMESPACE=default
export HELM_DEBUG=true
export HELM_VERBOSE=true


# set kubectl to be invoked via minikube
alias kubectl="minikube kubectl --"
alias k="minikube kubectl --"

echo ""
echo "-------------------------------------------------------------------------"
echo "Minikube Development Environment"
echo "https://minikube.sigs.k8s.io/docs/handbook/config/#environment-variables"
echo "KUBECONFIG: ${KUBECONFIG}"
echo "KUBECACHEDIR: ${KUBECACHEDIR}"
echo "MINIKUBE_HOME: ${MINIKUBE_HOME}"
echo "MINIKUBE_IN_STYLE: ${MINIKUBE_IN_STYLE}"
echo "CHANGE_MINIKUBE_NONE_USER: ${CHANGE_MINIKUBE_NONE_USER}"
echo "MINIKUBE_ENABLE_PROFILING: ${MINIKUBE_ENABLE_PROFILING}"
echo "MINIKUBE_SUPPRESS_DOCKER_PERFORMANCE: ${MINIKUBE_SUPPRESS_DOCKER_PERFORMANCE}"
echo "HELM_HOME: ${HELM_HOME}"
echo "HELM_REPOSITORY_CACHE: ${HELM_REPOSITORY_CACHE}"
echo "HELM_PLUGIN_DIR: ${HELM_PLUGIN_DIR}"
echo "HELM_NAMESPACE: ${HELM_NAMESPACE}"
echo "HELM_DEBUG: ${HELM_DEBUG}"
echo "HELM_VERBOSE: ${HELM_VERBOSE}"
echo "-------------------------------------------------------------------------"
echo ""