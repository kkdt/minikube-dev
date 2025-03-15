#!/bin/bash

__directory="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

__default_minikube="https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64"
__default_minikube_install="${__directory}/bin"

local-clean() {
    rm -rf ${__directory}/build

    if [ "${1}" == "all" ]; then
      rm -rf ${__directory}/.minikube
    fi
}

local-build() {
    mkdir -p ${__directory}/build/bin
    wget -O ${__directory}/build/minikube-binary ${__default_minikube}
    install ${__directory}/build/minikube-binary ${__directory}/build/bin/minikube && rm -f ${__directory}/build/minikube-binary
}

#---------------------------------------------------------------
# Environment
#---------------------------------------------------------------

export PATH=${__directory}/build/bin:$PATH

# No emoji icons
export MINIKUBE_IN_STYLE=0

# Manually set to this project; otherwise, default is ~/.minikube
export MINIKUBE_HOME=${__directory}/.minikube

# set kubectl to be invoked via minikube
alias kubectl="minikube kubectl --"

echo "-----------------------------------------"
echo "Minikube Development Environment"
echo "Type 'help' for more information"
echo "-----------------------------------------"

help() {
  echo "minikube-dev"
  echo ""
  echo "local-clean [args]: Clean up the environment"
  echo "    all   Pass in 'all' to also clean the MINIKUBE_HOME"
  echo ""
  echo "local-build : Set up the environment for minikube within this directory"
  echo ""
}