#/bin/bash

minikube profile tektoncd
minikube config set kubernetes-version "v1.13.2"
minikube config set memory "8192"
minikube config set cpus "4"
minikube config set vm-driver "kvm2"
minikube start

export GOBIN=/home/ltulloch/src/tektoncd/bin
export PATH=$PATH:$GOBIN
eval $(minikube docker-env)
export KO_DOCKER_REPO=ko.local

ko apply -f ./config
ko apply -f ./config/controller.yaml
kubectl apply -f examples/pipelineruns
kubectl apply -f examples/taskruns
kubectl apply -f ../cli/tekton
kubectl get all -n tekton-pipelines
