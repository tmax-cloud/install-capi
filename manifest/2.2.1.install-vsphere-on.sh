## Download govc
#curl -LO https://github.com/vmware/govmomi/releases/download/${GOVC_VERSION}/govc_linux_amd64.gz
#gzip -d govc_linux_amd64.gz
#chmod +x govc_linux_amd64
#sudo mv govc_linux_amd64 /usr/local/bin/govc

## Download yaml
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/releases/download/${VSPHERE_VERSION}/infrastructure-components.yaml > yaml/_template/infrastructure-components-vsphere-template-${VSPHERE_VERSION}.yaml

## Initialize capi-provider-vsphere settings
cp yaml/_template/infrastructure-components-vsphere-template-${VSPHERE_VERSION}.yaml yaml/_install/2.2.infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${VSPHERE_USERNAME}/'${VSPHERE_USERNAME}'/g' yaml/_install/2.2.infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${VSPHERE_PASSWORD}/'${VSPHERE_PASSWORD}'/g' yaml/_install/2.2.infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml

## Provision vsphere infrastructure
kubectl apply -f yaml/_install/2.2.infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml

## Download and apply catalog
#curl -L  https://github.com/tmax-cloud/install-capi/releases/download/v0.1.0/service-catalog-template-CAPI-vsphere.yaml > yaml/_catalog/2.service-catalog-template-CAPI-vsphere.yaml
#kubectl apply -f yaml/_catalog/2.service-catalog-template-CAPI-vsphere.yaml
