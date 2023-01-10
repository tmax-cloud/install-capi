## Make image dir for download capi, aws images
if [ ! -d img ]; then
   bash message.sh "ERROR" "'manifest/img/' is NOT EXIST!"
    exit 1
fi
if [ ! -f "registry.conf" ]; then
    bash message.sh "ERROR" "'registry.conf' is NOT EXIST!"
    exit 1
fi

source registry.conf
source version.conf

# cluster api
sudo docker load < img/cluster-api_cluster-api-controller_${CAPI_VERSION}.tar
TARGET=${REGISTRY}/cluster-api/cluster-api-controller:${CAPI_VERSION}
sudo docker tag registry.k8s.io/cluster-api/cluster-api-controller:${CAPI_VERSION} $TARGET
sudo docker push $TARGET

sudo docker load < img/cluster-api_kubeadm-bootstrap-controller_${CAPI_VERSION}.tar
TARGET=${REGISTRY}/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION}
sudo docker tag registry.k8s.io/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION} $TARGET
sudo docker push $TARGET

sudo docker load < img/cluster-api_kubeadm-control-plane-controller_${CAPI_VERSION}.tar
TARGET=${REGISTRY}/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION}
sudo docker tag registry.k8s.io/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION} $TARGET
sudo docker push $TARGET

# cluster api aws
sudo docker load < img/cluster-api-aws_cluster-api-aws-controller_${AWS_VERSION}.tar
TARGET=${REGISTRY}/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}
sudo docker tag registry.k8s.io/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION} $TARGET
sudo docker push $TARGET

# cluster api vphere
sudo docker load < img/cluster-api-vsphere_manager_${VSPHERE_VERSION}.tar
TARGET=${REGISTRY}/cluster-api-provider-vsphere/release/manager:${VSPHERE_VERSION}
sudo docker tag gcr.io/cluster-api-provider-vsphere/release/manager:${VSPHERE_VERSION} $TARGET 
sudo docker push $TARGET

sudo docker load < img/kube-vip_${KUBE_VIP_VERSION}.tar
TARGET=${REGISTRY}/kube-vip/kube-vip:${VSPHERE_VERSION}
sudo docker tag ghcr.io/kube-vip/kube-vip:${KUBE_VIP_VERSION} $TARGET
sudo docker push $TARGET\

sudo docker load < img/livenessprobe_${LIVE_PROBE_VERSION}.tar
TARGET=${REGISTRY}/k8scsi/livenessprobe:${VSPHERE_VERSION}
sudo docker tag quay.io/k8scsi/livenessprobe:${LIVE_PROBE_VERSION} $TARGET
sudo docker push $TARGET

sudo docker load < img/csi-attacher_${CSI_ATTACHER_VERSION}.tar
TARGET=${REGISTRY}/k8scsi/csi-attacher:${VSPHERE_VERSION}
sudo docker tag quay.io/k8scsi/csi-attacher:${CSI_ATTACHER_VERSION} $TARGET
sudo docker push $TARGET

sudo docker load < img/csi-provisioner_${CSI_PROVISIONER_VERSION}.tar
TARGET=${REGISTRY}/k8scsi/csi-provisioner:${VSPHERE_VERSION}
sudo docker tag quay.io/k8scsi/csi-provisioner:${CSI_PROVISOINER_VERSION} $TARGET
sudo docker push $TARGET

sudo docker load < img/csi-node-driver-registrar_${CSI_REG_VERSION}.tar
TARGET=${REGISTRY}/k8scsi/csi-node-driver-registrar:${VSPHERE_VERSION}
sudo docker tag quay.io/k8scsi/csi-node-driver-registrar:${CSI_REG_VERSION} $TARGET
sudo docker push $TARGET

sudo docker load < img/csi-driver_${CSI_DRIVER_VERSION}.tar
TARGET=${REGISTRY}/cloud-provider-vsphere/csi/release/driver:${VSPHERE_VERSION}
sudo docker tag gcr.io/cloud-provider-vsphere/csi/release/driver:${CSI_DRIVER_VERSION} $TARGET
sudo docker push $TARGET

sudo docker load < img/csi-syncer_${CSI_SYNCER_VERSION}.tar
TARGET=${REGISTRY}/cloud-provider-vsphere/csi/release/syncer:${VSPHERE_VERSION}
sudo docker tag gcr.io/cloud-provider-vsphere/csi/release/syncer:${CSI_SYNCER_VERSION} $TARGET
sudo docker push $TARGET

sudo docker load < img/csi-syncer_${CSI_SYNCER_VERSION}.tar
TARGET=${REGISTRY}/cloud-provider-vsphere/cpi/release/manager:${VSPHERE_VERSION}
sudo docker tag gcr.io/cloud-provider-vsphere/cpi/release/manager:${CSI_SYNCER_VERSION} $TARGET
sudo docker push $TARGET