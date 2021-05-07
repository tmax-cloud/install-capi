## Make image dir for download capi, aws images
if [ ! -d img ]; then
   mkdir img
fi

if [ ! -d yaml ]; then
   mkdir yaml
fi

if [ ! -d bin ]; then
   mkdir bin
fi

## Pull image: kube-rbac-proxy
sudo docker pull gcr.io/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION}
sudo docker save gcr.io/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION} > img/kubebuilder_kube-rbac-proxy_${KUBE_RBAC_PROXY_VERSION}.tar

sudo docker pull gcr.io/kubebuilder/kube-rbac-proxy:${VSPHERE_RBAC_PROXY_VERSION}
sudo docker save gcr.io/kubebuilder/kube-rbac-proxy:${VSPHERE_RBAC_PROXY_VERSION} > img/kubebuilder_kube-rbac-proxy_${VSPHERE_RBAC_PROXY_VERSION}.tar

## Pull images: 1.cluster-api-components
sudo docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/cluster-api-controller:${CAPI_VERSION}
sudo docker save us.gcr.io/k8s-artifacts-prod/cluster-api/cluster-api-controller:${CAPI_VERSION} > img/cluster-api_cluster-api-controller_${CAPI_VERSION}.tar

sudo docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION}
sudo docker save us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION} > img/cluster-api_kubeadm-bootstrap-controller_${CAPI_VERSION}.tar

sudo docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION}
sudo docker save us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION} > img/cluster-api_kubeadm-control-plane-controller_${CAPI_VERSION}.tar

## Pull images: 3.control-plane-components-aws.yaml
sudo docker pull us.gcr.io/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}
sudo docker save us.gcr.io/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION} > img/cluster-api-aws_cluster-api-aws-controller_${AWS_VERSION}.tar

## Pull images: 4.control-plane-componenets-vsphere.yaml
sudo docker pull plndr/kube-vip:${KUBE_VIP_VERSION}
sudo docker save plndr/kube-vip:${KUBE_VIP_VERSION} > img/kube-vip_${KUBE_VIP_VERSION}.tar

sudo docker pull quay.io/k8scsi/livenessprobe:${LIVE_PROBE_VERSION}
sudo docker save quay.io/k8scsi/livenessprobe:${LIVE_PROBE_VERSION} > img/livenessprobe_${LIVE_PROBE_VERSION}.tar

sudo docker pull quay.io/k8scsi/csi-attacher:${CSI_ATTACHER_VERSION}
sudo docker save quay.io/k8scsi/csi-attacher:${CSI_ATTACHER_VERSION} > img/csi-attacher_${CSI_ATTACHER_VERSION}.tar

sudo docker pull quay.io/k8scsi/csi-provisioner:${CSI_PROVISOINER_VERSION}
sudo docker save quay.io/k8scsi/csi-provisioner:${CSI_PROVISOINER_VERSION} > img/csi-provisioner_${CSI_PROVISIONER_VERSION}.tar

sudo docker pull quay.io/k8scsi/csi-node-driver-registrar:${CSI_REG_VERSION}
sudo docker save quay.io/k8scsi/csi-node-driver-registrar:${CSI_REG_VERSION} > img/csi-node-driver-registrar_${CSI_REG_VERSION}.tar

sudo docker pull gcr.io/cloud-provider-vsphere/csi/release/driver:${CSI_DRIVER_VERSION}
sudo docker save gcr.io/cloud-provider-vsphere/csi/release/driver:${CSI_DRIVER_VERSION} > img/csi-driver_${CSI_DRIVER_VERSION}.tar

sudo docker pull gcr.io/cloud-provider-vsphere/csi/release/syncer:${CSI_SYNCER_VERSION}
sudo docker save gcr.io/cloud-provider-vsphere/csi/release/syncer:${CSI_SYNCER_VERSION} > img/csi-syncer_${CSI_SYNCER_VERSION}.tar

## Download binary files and yaml files
# CAPI
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/clusterctl-linux-amd64 > bin/clusterctl
chmod +x bin/clusterctl
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/cluster-api-components.yaml > yaml/cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/${EXP_MACHINE_POOL:=false}/false/g' yaml/cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/${EXP_MACHINE_POOL:=true}/true/g' yaml/cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/${EXP_CLUSTER_RESOURCE_SET:=false}/false/g' yaml/cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/${EXP_CLUSTER_RESOURCE_SET:=true}/true/g' yaml/cluster-api-components-${CAPI_VERSION}.yaml

# CAPA
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/clusterawsadm-linux-amd64 > bin/clusterawsadm
chmod +x bin/clusterawsadm
curl -L https://github.com/tmax-cloud/install-capi/releases/download/v0.1.0/service-catalog-template-CAPI-aws.yaml > yaml/service-catalog-template-CAPI-aws.yaml

# CAPV
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-vsphere/releases/download/${VSPHERE_VERSION}/infrastructure-components.yaml > yaml/infrastructure-components-vsphere-${VSPHERE_VERSION}.yaml