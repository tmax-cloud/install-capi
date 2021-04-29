## make yaml dir
if [ ! -d yaml ]; then
    mkdir yaml
fi

## Download clusterctl
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/clusterctl-linux-amd64 -o clusterctl
chmod +x clusterctl
sudo mv clusterctl /usr/local/bin/clusterctl

## Download and provision CAPI
curl -L http://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/cluster-api-components.yaml > yaml/cluster-api-components-${CAPI_VERSION}.yaml
kubectl apply -f yaml/cluster-api-components-${CAPI_VERSION}.yaml

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE INSTALLATION!!!!! USE: kubectl get pods -A | grep capi"
echo ""
echo ""