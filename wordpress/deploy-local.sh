#!/bin/bash

wp_deploy() {
    # create local persistent volume claims for database and wordpress
    kubectl apply -f pv-local.yaml
    kubectl apply -f pvc-local.yaml

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
    kubectl delete -f pvc-local.yaml
    kubectl delete -f pv-local.yaml
}

if [[ $1 =~ "down" ]]; then
    wp_clean
else
    wp_deploy
fi


