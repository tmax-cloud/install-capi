## Download resources(yaml, binaries) and install binaries
## clusterctl
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/clusterctl-linux-amd64 -o clusterctl
chmod +x clusterctl
mv clusterctl /usr/local/bin/clusterctl

## cert-manager
curl -L https://github.com/jetstack/cert-manager/releases/download/"$CERT_MANAGER_VERSION"/cert-manager.yaml -o cert-manager-${CERT_MANAGER_VERSION}.yaml > yaml/_template/cert-manager-${CERT_MANAGER_VERSION}.yaml
cp yaml/_template/cert-manager-${CERT_MANAGER_VESION}.yaml yaml/_install/0.cert-manager-${CERT_MANAGER_VERSION}.yaml
kubectl apply -f yaml/_install/0.cert-manager-${CERT_MANAGER_VERSION}.yaml

## CAPI
curl -L http://github.com/kubernetes-sigs/cluster-api/releases/download/"$CAPI_VERSION"/cluster-api-components.yaml > yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml 
cp yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
kubectl apply -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml