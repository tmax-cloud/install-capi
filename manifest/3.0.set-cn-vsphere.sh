source version.conf

## Register images to registry
sudo docker load < img/kubebuilder_kube-rbac-proxy_${VSPHERE_RBAC_PROXY_VERSION}.tar
sudo docker tag gcr.io/kubebuilder/kube-rbac-proxy:${VSPHERE_RBAC_PROXY_VERSION} ${REGISTRY}/kubebuilder/kube-rbac-proxy:${VSPHERE_RBAC_PROXY_VERSION}
sudo docker push ${REGISTRY}/kubebuilder/kube-rbac-proxy:${VSPHERE_RBAC_PROXY_VERSION}

sudo docker load < img/cluster-api-vsphere_manager_${VSPHERE_VERSION}.tar
sudo docker tag gcr.io/cluster-api-provider-vsphere/release/manager:${VSPHERE_VERSION} ${REGISTRY}/cluster-api-provider-vsphere/release/manager:${VSPHERE_VERSION}
sudo docker push ${REGISTRY}/cluster-api-provider-vsphere/release/manager:${VSPHERE_VERSION}

sudo docker load < img/kube-vip_${KUBE_VIP_VERSION}.tar
sudo docker tag plndr/kube-vip:${KUBE_VIP_VERSION} ${REGISTRY}/kube-vip:${KUBE_VIP_VERSION}
sudo docker push ${REGISTRY}/kube-vip:${KUBE_VIP_VERSION}

sudo docker load < img/livenessprobe_${LIVE_PROBE_VERSION}.tar
sudo docker tag quay.io/k8scsi/livenessprobe:${LIVE_PROBE_VERSION} ${REGISTRY}/k8scsi/livenessprobe:${LIVE_PROBE_VERSION}
sudo docker push ${REGISTRY}/k8scsi/livenessprobe:${LIVE_PROBE_VERSION}

sudo docker load < img/csi-attacher_${CSI_ATTACHER_VERSION}.tar
sudo docker tag quay.io/k8scsi/csi-attacher:${CSI_ATTACHER_VERSION} ${REGISTRY}/k8scsi/csi-attacher:${CSI_ATTACHER_VERSION}
sudo docker push ${REGISTRY}/k8scsi/csi-attacher:${CSI_ATTACHER_VERSION}

sudo docker load < img/csi-provisioner_${CSI_PROVISIONER_VERSION}.tar
sudo docker tag quay.io/k8scsi/csi-provisioner:${CSI_PROVISOINER_VERSION} ${REGISTRY}/k8scsi/csi-provisioner:${CSI_PROVISOINER_VERSION}
sudo docker push ${REGISTRY}/k8scsi/csi-provisioner:${CSI_PROVISOINER_VERSION}

sudo docker load < img/csi-node-driver-registrar_${CSI_REG_VERSION}.tar
sudo docker tag quay.io/k8scsi/csi-node-driver-registrar:${CSI_REG_VERSION} ${REGISTRY}/k8scsi/csi-node-driver-registrar:${CSI_REG_VERSION}
sudo docker push ${REGISTRY}/k8scsi/csi-node-driver-registrar:${CSI_REG_VERSION}

sudo docker load < img/csi-driver_${CSI_DRIVER_VERSION}.tar
sudo docker tag gcr.io/cloud-provider-vsphere/csi/release/driver:${CSI_DRIVER_VERSION} ${REGISTRY}/cloud-provider-vsphere/csi/release/driver:${CSI_DRIVER_VERSION}
sudo docker push ${REGISTRY}/cloud-provider-vsphere/csi/release/driver:${CSI_DRIVER_VERSION}

sudo docker load < img/csi-syncer_${CSI_SYNCER_VERSION}.tar
sudo docker tag gcr.io/cloud-provider-vsphere/csi/release/syncer:${CSI_SYNCER_VERSION} ${REGISTRY}/cloud-provider-vsphere/csi/release/syncer:${CSI_SYNCER_VERSION}
sudo docker push ${REGISTRY}/cloud-provider-vsphere/csi/release/syncer:${CSI_SYNCER_VERSION}

## Change image registry
sed -i 's/gcr.io\/kubebuilder\/kube-rbac-proxy:'"${VSPHERE_RBAC_PROXY_VERSION}"'/'"${REGISTRY}"'\/kubebuilder\/kube-rbac-proxy:'"${VSPHERE_RBAC_PROXY_VERSION}"'/g' yaml/infrastructure-components-vsphere-${AWS_VERSION}.yaml
sed -i 's/gcr.io\/cluster-api-provider-vsphere\/release\/manager:'"${VSPHERE_VERSION}"'/'"${REGISTRY}"'\/cluster-api-provider-vsphere\/release\/manager:'"${VSPHERE_VERSION}"'/g' yaml/infrastructure-components-vsphere-${AWS_VERSION}.yaml

sed -i 's/plndr\/kube-vip:'"${KUBE_VIP_VERSION}"'/'"${REGISTRY}"'\/kube-vip:'"${KUBE_VIP_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/quay.io\/k8scsi\/livenessprobe:'"${LIVE_PROBE_VERSION}"'/'"${REGISTRY}"'\/k8scsi\/livenessprobe:'"${LIVE_PROBE_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/quay.io\/k8scsi\/csi-attacher:'"${CSI_ATTACHER_VERSION}"'/'"${REGISTRY}"'\/k8scsi\/csi-attacher:'"${CSI_ATTACHER_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/quay.io\/k8scsi\/csi-provisioner:'"${CSI_PROVISIONER_VERSION}"'/'"${REGISTRY}"'\/k8scsi\/csi-provisioner:'"${CSI_PROVISIONER_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/quay.io\/k8scsi\/csi-node-driver-registrar:'"${CSI_REG_VERSION}"'/'"${REGISTRY}"'\/k8scsi\/csi-node-driver-registrar:'"${CSI_REG_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/gcr.io\/cloud-provider-vsphere\/csi\/release\/driver:'"${CSI_DRIVER_VERSION}"'/'"${REGISTRY}"'\/cloud-provider-vsphere\/csi\/release\/driver:'"${CSI_DRIVER_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml
sed -i 's/gcr.io\/cloud-provider-vsphere\/csi\/release\/syncer:'"${CSI_SYNCER_VERSION}"'/'"${REGISTRY}"'\/cloud-provider-vsphere\/csi\/release\/syncer:'"${CSI_SYNCER_VERSION}"'/g' yaml/service-catalog-template-CAPI-vsphere-${VSPHERE_VERSION}.yaml

bash message.sh "SUCCESS" "run 'bash 3.1.install-vsphere.sh'"
