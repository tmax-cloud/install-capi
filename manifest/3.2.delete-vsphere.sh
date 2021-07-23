source version.conf

## Delete CAPI-provider-vsphere infrastructure
kubectl delete -f yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml

bash message.sh "SUCCESS" "CAPI-provider-vsphere is deleted"
