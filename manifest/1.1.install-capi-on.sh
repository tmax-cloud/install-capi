## make yaml dir
if [ ! -d yaml ]; then
    mkdir yaml
    mkdir yaml/_template
    mkdir yaml/_install
    mkdir yaml/_catalog
fi

## Download clusterctl
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/clusterctl-linux-amd64 -o clusterctl
chmod +x clusterctl
sudo mv clusterctl /usr/local/bin/clusterctl

## Download and provision CAPI
curl -L http://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/cluster-api-components.yaml > yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml 
cp yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
kubectl apply -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml