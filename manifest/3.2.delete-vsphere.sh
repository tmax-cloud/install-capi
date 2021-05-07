source version.conf

## Delete CAPI-provider-vsphere infrastructure
kubectl delete -f yaml/service-catalog-template-CAPI-vsphere.yaml
kubectl delete -f yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE UNINSTALLATION!!!!!"
echo ""
echo ""