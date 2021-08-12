source version.conf

## Delete CAPI-provider-aws infrastructure
kubectl delete -f yaml/infrastructure-components-aws-${AWS_VERSION}.yaml

bash message.sh "SUCCESS" "CAPI-provider-aws is deleted"