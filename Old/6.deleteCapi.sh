kubectl delete -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
kubectl delete -f yaml/_install/2.infrastructure-components-aws-${AWS_VERSION}.yaml

rm -rf img/ yaml/ aws/ \
    /usr/local/bin/clusterctl \
    /usr/local/bin/clusterawsadm \
    /usr/local/aws-cli \
    /usr/local/bin/aws \
    /usr/local/bin/aws_completer \
    ~/.aws
