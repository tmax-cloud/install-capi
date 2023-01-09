if [ ! -f "registry.conf" ]; then
    bash message.sh "ERROR" "'registry.conf' is NOT EXIST!"
    exit 0
fi

source registry.conf
source version.conf

## Push image to REGISTRY: cluster-api-components.yaml
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

## Change image registry
CP_FILE=capi/offline-cluster-api-componenets.yaml
cp capi/cluster-api-componenets.yaml 
sed -i 's/registry.k8s.io\/cluster-api\/cluster-api-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/cluster-api\/cluster-api-controller:'"${CAPI_VERSION}"'/g' $CP_FILE
sed -i 's/registry.k8s.io\/cluster-api\/kubeadm-bootstrap-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/cluster-api\/kubeadm-bootstrap-controller:'"${CAPI_VERSION}"'/g' capi/offline-cluster-api-componenets.yaml
sed -i 's/registry.k8s.io\/cluster-api\/kubeadm-control-plane-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/cluster-api\/kubeadm-control-plane-controller:'"${CAPI_VERSION}"'/g' capi/offline-cluster-api-componenets.yaml
