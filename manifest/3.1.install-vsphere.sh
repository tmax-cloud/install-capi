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

bash message.sh "SUCCESS" "run 'kubectl get pods -A | grep capv'"