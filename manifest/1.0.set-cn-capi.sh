if [ ! -f "registry.conf" ]; then
    bash message.sh "ERROR" "'registry.conf' is NOT EXIST!"
    exit 0
fi

source registry.conf
source version.conf

## Push image to REGISTRY: kube-rbac-proxy
sudo docker load < img/kubebuilder_kube-rbac-proxy_${KUBE_RBAC_PROXY_VERSION}.tar 
sudo docker tag gcr.io/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION} ${REGISTRY}/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION}
sudo docker push ${REGISTRY}/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION}

## Push image to REGISTRY: cluster-api-components.yaml
sudo docker load < img/cluster-api_cluster-api-controller_${CAPI_VERSION}.tar
sudo docker tag us.gcr.io/k8s-artifacts-prod/cluster-api/cluster-api-controller:${CAPI_VERSION} ${REGISTRY}/k8s-artifacts-prod/cluster-api/cluster-api-controller:${CAPI_VERSION}
sudo docker push ${REGISTRY}/k8s-artifacts-prod/cluster-api/cluster-api-controller:${CAPI_VERSION}

sudo docker load < img/cluster-api_kubeadm-bootstrap-controller_${CAPI_VERSION}.tar
sudo docker tag us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION} ${REGISTRY}/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION}
sudo docker push ${REGISTRY}/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:${CAPI_VERSION}

sudo docker load < img/cluster-api_kubeadm-control-plane-controller_${CAPI_VERSION}.tar
sudo docker tag us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION} ${REGISTRY}/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION}
sudo docker push ${REGISTRY}/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:${CAPI_VERSION}

## Change image registry
sed -i 's/gcr.io\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/'"${REGISTRY}"'\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/g' yaml/cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api\/cluster-api-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/k8s-artifacts-prod\/cluster-api\/cluster-api-controller:'"${CAPI_VERSION}"'/g' yaml/cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api\/kubeadm-bootstrap-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/k8s-artifacts-prod\/cluster-api\/kubeadm-bootstrap-controller:'"${CAPI_VERSION}"'/g' yaml/cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api\/kubeadm-control-plane-controller:'"${CAPI_VERSION}"'/'"${REGISTRY}"'\/k8s-artifacts-prod\/cluster-api\/kubeadm-control-plane-controller:'"${CAPI_VERSION}"'/g' yaml/cluster-api-components-${CAPI_VERSION}.yaml

bash message.sh "SUCCESS" "run 'bash 1.1.install-capi.sh'"
