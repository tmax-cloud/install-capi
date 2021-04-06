## Delete CAPI
kubectl delete -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
kubectl delete -f yaml/_install/0.cert-manager-${CERT_MANAGER_VERSION}.yaml
sudorm -rf yaml/ img/ \
    /usr/local/bin/clusterctl