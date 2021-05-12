## Delete CAPI-provider-aws infrastructure
kubectl delete -f yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml
#clusterawsadm bootstrap iam delete-cloudformation-stack
sudo rm -f /usr/local/bin/clusterawsadm \
    yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml
