## Delete CAPI
kubectl delete -f yaml/cluster-api-components-${CAPI_VERSION}.yaml
sudo rm -rf yaml/ img/ bin/ \
    /usr/local/bin/clusterctl