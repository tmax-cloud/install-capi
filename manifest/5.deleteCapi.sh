## Delete Capi
kubectl delete -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
rm -rf img/ yaml/ \
    /usr/local/bin/clusterctl