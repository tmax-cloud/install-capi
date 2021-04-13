## Set environment
cp -r $FILE_DIR/img $HOME/install-capi/img
mkdir $HOME/install-capi/yaml
mkdir $HOME/install-capi/yaml/_template
mkdir $HOME/install-capi/yaml/_install
mkdir $HOME/install-capi/yaml/_catalog
cp $FILE_DIR/yaml/_template/cert-manager-${CERT_MANAGER_VERSION}.yaml yaml/_template/cert-manager-${CERT_MANAGER_VERSION}.yaml
cp $FILE_DIR/yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml
sudo cp $FILE_DIR/clusterctl /usr/local/bin/clusterctl

## Push image to REGISTRY: kube-rbac-proxy
docker load < $HOME/install-capi/img/kubebuilder_kube-rbac-proxy_$KUBE_RBAC_PROXY_VERSION.tar 
docker tag gcr.io/kubebuilder/kube-rbac-proxy:$KUBE_RBAC_PROXY_VERSION $REGISTRY/kubebuilder/kube-rbac-proxy:$KUBE_RBAC_PROXY_VERSION
docker push $REGISTRY/kubebuilder/kube-rbac-proxy:$KUBE_RBAC_PROXY_VERSION

## Push image to REGISTRY: 0.cert-manager.yaml
docker load < $HOME/install-capi/img/cert-manager-controller:$CERT_MANAGER_VERSION.tar
docker tag quay.io/jetstack/cert-manager-controller:$CERT_MANAGER_VERSION $REGISTRY/jetstack/cert-manager-controller:$CERT_MANAGER_VERSION
docker push $REGISTRY/jetstack/cert-manager-controller:$CERT_MANAGER_VERSION

docker load < $HOME/install-capi/img/cert-manager-webhook:$CERT_MANAGER_VERSION.tar
docker tag quay.io/jetstack/cert-manager-webhook:$CERT_MANAGER_VERSION $REGISTRY/jetstack/cert-manager-webhook:$CERT_MANAGER_VERSION
docker push $REGISTRY/jetstack/cert-manager-webhook:$CERT_MANAGER_VERSION

docker load < $HOME/install-capi/img/cert-manager-cainjector:$CERT_MANAGER_VERSION.tar
docker tag quay.io/jetstack/cert-manager-cainjector:$CERT_MANAGER_VERSION $REGISTRY/jetstack/cert-manager-cainjector:$CERT_MANAGER_VERSION
docker push $REGISTRY/jetstack/cert-manager-cainjector:$CERT_MANAGER_VERSION

## Push image to REGISTRY: 1.cluster-api-components.yaml
docker load < $HOME/install-capi/img/cluster-api_cluster-api-controller_$CAPI_VERSION.tar
docker tag us.gcr.io/k8s-artifacts-prod/cluster-api/cluster-api-controller:$CAPI_VERSION $REGISTRY/k8s-artifacts-prod/cluster-api/cluster-api-controller:$CAPI_VERSION
docker push $REGISTRY/k8s-artifacts-prod/cluster-api/cluster-api-controller:$CAPI_VERSION

docker load < $HOME/install-capi/img/cluster-api_kubeadm-bootstrap-controller_$CAPI_VERSION.tar
docker tag us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:$CAPI_VERSION $REGISTRY/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:$CAPI_VERSION
docker push $REGISTRY/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:$CAPI_VERSION

docker load < $HOME/install-capi/img/cluster-api_kubeadm-control-plane-controller_$CAPI_VERSION.tar
docker tag us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:$CAPI_VERSION $REGISTRY/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:$CAPI_VERSION
docker push $REGISTRY/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:$CAPI_VERSION

## Change image registry
cp $HOME/install-capi/yaml/_template/cert-manager-${CERT_MANAGER_VERSION}.yaml $HOME/install-capi/yaml/_template/0.cert-manager-${CERT_MANAGER_VERSION}.yaml
sed -i 's/quay.io\/jetstack\/cert-manager-controller:'${CERT_MANAGER_VERSION}'/'${REGISTRY}'\/jetstack\/cert-manager-controller:'${CERT_MANAGER_VERSION}'/g' $HOME/install-capi/yaml/_install/0.cert-manager-${CERT_MANAGER_VERSION}.yaml
sed -i 's/quay.io\/jetstack\/cert-manager-webhook:'${CERT_MANAGER_VERSION}'/'${REGISTRY}'\/jetstack\/cert-manager-webhook:'${CERT_MANAGER_VERSION}'/g' $HOME/install-capi/yaml/_install/0.cert-manager-${CERT_MANAGER_VERSION}.yaml
sed -i 's/quay.io\/jetstack\/cert-manager-cainjector:'${CERT_MANAGER_VERSION}'/'${REGISTRY}'\/jetstack\/cert-manager-cainjector:'${CERT_MANAGER_VERSION}'/g' $HOME/install-capi/yaml/_install/0.cert-manager-${CERT_MANAGER_VERSION}.yaml

cp $HOME/install-capi/yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml $HOME/install-capi/yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/gcr.io\/kubebuilder\/kube-rbac-proxy:'${KUBE_RBAC_PROXY_VERSION}'/'${REGISTRY}'\/kubebuilder\/kube-rbac-proxy:'${KUBE_RBAC_PROXY_VERSION}'/g' $HOME/install-capi/yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api\/cluster-api-controller:'${CAPI_VERSION}'/'${REGISTRY}'\/k8s-artifacts-prod\/cluster-api\/cluster-api-controller:'${CAPI_VERSION}'/g' $HOME/install-capi/yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api\/kubeadm-bootstrap-controller:'${CAPI_VERSION}'/'${REGISTRY}'\/k8s-artifacts-prod\/cluster-api\/kubeadm-bootstrap-controller:'${CAPI_VERSION}'/g' $HOME/install-capi/yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api\/kubeadm-control-plane-controller:'${CAPI_VERSION}'/'${REGISTRY}'\/k8s-artifacts-prod\/cluster-api\/kubeadm-control-plane-controller:'${CAPI_VERSION}'/g' $HOME/install-capi/yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml

## Provision cert-manager, CAPI
kubectl apply -f yaml/_install/0.cert-manager-${CERT_MANAGER_VERSION}.yaml
kubectl apply -f yaml/_install/1.cluster-api-components-${CAPI_VERSION}.yaml