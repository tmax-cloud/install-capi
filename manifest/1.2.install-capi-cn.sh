## Set environment
sudo cp bin/clusterctl /usr/local/bin/clusterctl

## Push image to REGISTRY: kube-rbac-proxy
sudo docker load < img/kubebuilder_kube-rbac-proxy_${KUBE_RBAC_PROXY_VERSION}.tar 
sudo docker tag gcr.io/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION} ${REGISTRY}/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION}
sudo docker push ${REGISTRY}/kubebuilder/kube-rbac-proxy:${KUBE_RBAC_PROXY_VERSION}

## Push image to REGISTRY: 1.cluster-api-components.yaml
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

## Provision cert-manager, CAPI
kubectl apply -f yaml/cluster-api-components-${CAPI_VERSION}.yaml

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE INSTALLATION!!!!! USE: kubectl get pods -A | grep capi"
echo ""
echo ""