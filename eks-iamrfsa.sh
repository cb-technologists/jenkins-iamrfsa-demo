#!/usr/env/bin bash

source .env

# create cluster
eksctl create cluster --name $CLUSTER_NAME --version 1.14 --nodegroup-name standard-workers \
  --node-type t3.medium --nodes 3 --nodes-min 1 --nodes-max 5 --node-ami auto --region $REGION --profile $PROFILE

# enable IAMRFSA
eksctl utils associate-iam-oidc-provider --cluster $CLUSTER_NAME --region $REGION --approve --profile $PROFILE

# install CloudBees Core
kubectl create namespace cloudbees-core
helm install cloudbees-core cloudbees/cloudbees-core --namespace cloudbees-core \
  --set nginx-ingress.Enabled=true --set OperationsCenter.HostName=$HOSTNAME

# create IAM SA
eksctl create iamserviceaccount --name jenkins --namespace cloudbees-core \
  --cluster $CLUSTER_NAME --attach-policy-arn $IAM_POLICY_ARN --approve --override-existing-serviceaccounts \
  --region $REGION --profile $PROFILE
