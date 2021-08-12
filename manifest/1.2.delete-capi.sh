source version.conf

## Delete CAPI
kubectl delete -f yaml/cluster-api-components-${CAPI_VERSION}.yaml

bash message.sh "SUCCESS" "CAPI is deleted"