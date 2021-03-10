## Delete Capi
kubectl delete -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
rm -rf img/ yaml/ \
    /usr/local/bin/clusterctl \

## Delete AWS Provider infrastructure
kubectl delete -f yaml/_install/2.infrastructure-components-aws-${AWS_VERSION}.yaml
rm -rf aws/ \    
    /usr/local/aws-cli \
    /usr/local/bin/aws \
    /usr/local/bin/aws_completer \
    ~/.aws
    /usr/local/bin/clusterawsadm \
