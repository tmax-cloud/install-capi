if [ ! -f "vsphere-credential.conf" ]; then
    bash message.sh "ERROR" "'vsphere-credential.conf' is NOT EXIST!"
	exit 0
fi

source version.conf
source vsphere-credential.conf

## Install CAPV infrastructure comopnents
sed -i 's/${VSPHERE_USERNAME}/'${VSPHERE_USERNAME}'/g' yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${VSPHERE_PASSWORD}/'${VSPHERE_PASSWORD}'/g' yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml
kubectl apply -f yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml

## Install service catalog template
sed -i 's/${KUBE_VIP_VERSION}/'"${KUBE_VIP_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${LIVE_PROBE_VERSION}/'"${LIVE_PROBE_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${CSI_REG_VERSION}/'"${CSI_REG_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${CSI_ATTACHER_VERSION}/'"${CSI_ATTACHER_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${CSI_PROVISIONER_VERSION}/'"${CSI_PROVISIONER_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${CSI_DRIVER_VERSION}/'"${CSI_DRIVER_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/${CSI_SYNCER_VERSION}/'"${CSI_SYNCER_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
kubectl apply -f yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml

bash message.sh "SUCCESS" "run 'kubectl get pods -A | grep capv'"