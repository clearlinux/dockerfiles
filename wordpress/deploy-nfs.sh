#!/bin/bash

wp_deploy() {
    # create nfs persistent volume claims for database and wordpress
    kubectl apply -f rbac.yaml
    kubectl apply -f nfs-deployment.yaml
    kubectl apply -f pvc-nfs.yaml

    # create secret password for database
    kubectl apply -f secret.yaml

    # deploy database and wordpress
    kubectl apply -f mysql-deployment.yaml
    kubectl apply -f wordpress-deployment.yaml
}

wp_clean() {
    kubectl delete -f wordpress-deployment.yaml
    kubectl delete -f mysql-deployment.yaml
    kubectl delete -f secret.yaml
    kubectl delete -f pvc-nfs.yaml
    kubectl delete -f nfs-deployment.yaml
    kubectl delete -f rbac.yaml
}

if [[ $1 =~ "down" ]]; then
    wp_clean
else
    wp_deploy
fi


