## Delete CAPI-provider-aws infrastructure
kubectl delete -f yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml
clusterawsadm bootstrap iam delete-cloudformation-stack
rm -f /usr/local/bin/clusterawsadm \
    yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml \
    yaml/_template/cluster-aws-template-${AWS_VERSION}.yaml \
    yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml