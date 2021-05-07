source version.conf

## Install clusterctl
chmod +x clusterctl
sudo cp clusterctl /usr/local/bin/clusterctl

## Download and provision CAPI
kubectl apply -f yaml/cluster-api-components-${CAPI_VERSION}.yaml

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE INSTALLATION!!!!! USE: kubectl get pods -A | grep capi"
echo ""
echo ""
