## Delete CAPI-provider-vsphere infrastructure
kubectl delete -f yaml/_catalog/2.service-catalog-template-CAPI-vsphere.yaml
kubectl delete -f yaml/_install/2.2.infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
sudo rm -f /usr/local/bin/govc \
    yaml/_catalog/2.service-catalog-template-CAPI-vsphere.yaml \
    yaml/_install/2.2.infrastructure-components-vsphere-${VSPHERE_VSERION}.yaml \
    yaml/_template/infrastructure-components-vsphere-template-${VSPHERE_VSERION}.yaml
