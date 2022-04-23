#!/bin/bash
eksctl create cluster -f cluster-eks.yaml 
aws eks --region us-west-2 update-kubeconfig --name ark-eks-cluster
