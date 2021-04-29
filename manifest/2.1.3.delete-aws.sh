## Delete CAPI-provider-aws infrastructure
kubectl delete -f yaml/service-catalog-template-CAPI-aws.yaml
kubectl delete -f yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
#clusterawsadm bootstrap iam delete-cloudformation-stack
sudo rm -f /usr/local/bin/clusterawsadm \
    yaml/service-catalog-template-CAPI-aws.yaml \
    yaml/infrastructure-components-aws-${AWS_VERSION}.yaml