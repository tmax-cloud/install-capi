## Delete CAPI-provider-vsphere infrastructure
kubectl delete -f yaml/service-catalog-template-CAPI-vsphere.yaml
kubectl delete -f yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
sudo rm -f \
    yaml/infrastructure-components-vsphere-${VSPHERE_VSERION}.yaml