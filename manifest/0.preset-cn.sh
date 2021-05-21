## Make image dir for download capi, aws images
if [ ! -d img ]; then
   mkdir img
fi

source version.conf

## Pull image: kube-rbac-proxy
sudo docker pull gcr.io/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION}
sudo docker save gcr.io/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION} > img/kubebuilder_kube-rbac-proxy_${KUBE_RBAC_PROXY_VERSION}.tar

sudo docker pull gcr.io/kubebuilder/kube-rbac-proxy:${VSPHERE_RBAC_PROXY_VERSION}
sudo docker save gcr.io/kubebuilder/kube-rbac-proxy:${VSPHERE_RBAC_PROXY_VERSION} > img/kubebuilder_kube-rbac-proxy_${VSPHERE_RBAC_PROXY_VERSION}.tar

## Pull images: cluster-api-components
sudo docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/cluster-api-controller:${CAPI_VERSION}
sudo docker save us.gcr.io/k8s-artifacts-prod/cluster-api/cluster-api-controller:${CAPI_VERSION} > img/cluster-api_cluster-api-controller_${CAPI_VERSION}.tar

sudo docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION}
sudo docker save us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION} > img/cluster-api_kubeadm-bootstrap-controller_${CAPI_VERSION}.tar

sudo docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION}
sudo docker save us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION} > img/cluster-api_kubeadm-control-plane-controller_${CAPI_VERSION}.tar

## Pull images: control-plane-components-aws.yaml
sudo docker pull gcr.io/k8s-staging-cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}
sudo docker save gcr.io/k8s-staging-cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION} > img/cluster-api-aws_cluster-api-aws-controller_${AWS_VERSION}.tar

## Pull images: control-plane-componenets-vsphere.yaml
sudo docker pull gcr.io/cluster-api-provider-vsphere/release/manager:${VSPHERE_VERSION}
sudo docker save gcr.io/cluster-api-provider-vsphere/release/manager:${VSPHERE_VERSION} > img/cluster-api-vsphere_manager_${VSPHERE_VERSION}.tar

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