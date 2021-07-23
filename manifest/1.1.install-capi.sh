source version.conf

## Download and provision CAPI
kubectl apply -f yaml/cluster-api-components-${CAPI_VERSION}.yaml

bash message.sh "SUCCESS" "see 'kubectl get pods -A | grep capi'"