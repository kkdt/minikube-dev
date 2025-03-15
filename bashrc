#!/bin/bash

__directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
__default_minikube_install="${__directory}/bin"

local-clean() {
  rm -rf ${__directory}/build

  if [ "${1}" == "all" ]; then
    rm -rf ${__directory}/.minikube
    rm -rf ${__directory}/.kube
  fi
}

local-build() {
  local __default_minikube="https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"

  if [ ! -z "${1}" ]; then
    __default_minikube="https://storage.googleapis.com/minikube/releases/${1}/minikube-linux-amd64"
  fi

  mkdir -p ${__directory}/build/bin
  wget -O ${__directory}/build/minikube-binary ${__default_minikube}
  if [ $? -ne 0 ]; then
    return 1
  fi
  install ${__directory}/build/minikube-binary ${__directory}/build/bin/minikube && rm -f ${__directory}/build/minikube-binary
}

#---------------------------------------------------------------
# Environment
#---------------------------------------------------------------

export PATH=${__directory}/build/bin:$PATH

export KUBECONFIG=${__directory}/.kube/config

export KUBECACHEDIR=${__directory}/.kube/cache

# No emoji icons
export MINIKUBE_IN_STYLE=0

# Manually set to this project; otherwise, default is ~/.minikube
export MINIKUBE_HOME=${__directory}/.minikube

# Automatically change ownership of ~/.minikube to the value of $SUDO_USER 
export CHANGE_MINIKUBE_NONE_USER=true

# Enable/disable trace profiling to be generated for minikube
export MINIKUBE_ENABLE_PROFILING=0

# Suppresses Docker performance warnings when Docker is slow
export MINIKUBE_SUPPRESS_DOCKER_PERFORMANCE=true

# set kubectl to be invoked via minikube
alias kubectl="minikube kubectl --"

echo ""
echo "-------------------------------------------------------------------------"
echo "Minikube Development Environment"
echo "https://minikube.sigs.k8s.io/docs/handbook/config/#environment-variables"
echo "-------------------------------------------------------------------------"
echo ""