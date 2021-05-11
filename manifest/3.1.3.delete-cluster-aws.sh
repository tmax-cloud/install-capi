## Delete CAPI-provider-aws infrastructure
kubectl delete -f yaml/_install/2.2.cluster-template-aws-${AWS_VERSION}.yaml
sudo rm -f yaml/_install/2.2.cluster-template-aws-${AWS_VERSION}.yaml