## Delete CAPI-provider-vsphere infrastructure
kubectl delete -f yaml/_install/2.2.infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
rm -f /usr/local/bin/govc \
    yaml/_template/infrastructure-components-vsphere-template-${VSPHERE_VSERION}.yaml \
    yaml/_template/cluster-vsphere-template-${VSPHERE_VSERION}.yaml \
    yaml/_install/2.2.infrastructure-components-vsphere-${VSPHERE_VSERION}.yaml \