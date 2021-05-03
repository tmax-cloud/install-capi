## Install CAPV infrastructure comopnents
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/releases/download/${VSPHERE_VERSION}/infrastructure-components.yaml > yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${VSPHERE_USERNAME}/'${VSPHERE_USERNAME}'/g' yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${VSPHERE_PASSWORD}/'${VSPHERE_PASSWORD}'/g' yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
kubectl apply -f yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml

## Install service catalog template
curl -L  https://github.com/tmax-cloud/install-capi/releases/download/v0.1.0/service-catalog-template-CAPI-vsphere.yaml > yaml/service-catalog-template-CAPI-vsphere.yaml
kubectl apply -f yaml/service-catalog-template-CAPI-vsphere.yaml

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE INSTALLATION!!!!! USE: kubectl get pods -A | grep capv"
echo ""
echo ""
