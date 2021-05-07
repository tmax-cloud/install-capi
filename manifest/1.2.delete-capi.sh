source version.conf

## Delete CAPI
kubectl delete -f yaml/cluster-api-components-${CAPI_VERSION}.yaml
sudo rm -f /usr/local/bin/clusterctl

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE UNINSTALLATION!!!!!"
echo ""
echo ""