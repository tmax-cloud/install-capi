## Delete CAPI
kubectl delete -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
sudo rm -rf yaml/ img/ bin/ \
    /usr/local/bin/clusterctl