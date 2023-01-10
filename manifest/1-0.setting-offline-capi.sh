if [ ! -f "registry.conf" ]; then
    bash message.sh "ERROR" "'registry.conf' is NOT EXIST!"
    exit 0
fi

source registry.conf
source version.conf

## Change image registry
FILE=capi/cluster-api-componenets.yaml
sed -i 's/registry.k8s.io\/cluster-api\/cluster-api-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/cluster-api\/cluster-api-controller:'"${CAPI_VERSION}"'/g' $FILE
sed -i 's/registry.k8s.io\/cluster-api\/kubeadm-bootstrap-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/cluster-api\/kubeadm-bootstrap-controller:'"${CAPI_VERSION}"'/g' $FILE
sed -i 's/registry.k8s.io\/cluster-api\/kubeadm-control-plane-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/cluster-api\/kubeadm-control-plane-controller:'"${CAPI_VERSION}"'/g' $FILE
