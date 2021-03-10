## Download resources(yaml, binaries) and install binaries
## clusterctl
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/clusterctl-linux-amd64 -o clusterctl
chmod +x clusterctl
mv clusterctl /usr/local/bin/clusterctl

## download yaml
curl -L http://github.com/kubernetes-sigs/cluster-api/releases/download/"$CAPI_VERSION"/cluster-api-components.yaml > yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml 

## init capi settings
cp yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml

## provision capi crd
kubectl apply -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
