if [ ! -f "registry.conf" ]; then
    bash message.sh "ERROR" "'registry.conf' is NOT EXIST!"
    exit 0
fi

source registry.conf
source version.conf

## Register images to registry
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


## Change image registry

CP_FILE=capv/offline-infrastructure-components.yaml
cp capv/infrastructure-components.yaml $CP_FILE

sed -i 's/gcr.io\/cluster-api-provider-vsphere\/release\/manager:'"${VSPHERE_VERSION}"'/'"${REGISTRY}"'\/cluster-api-provider-vsphere\/release\/manager:'"${VSPHERE_VERSION}"'/g' $CP_FILE