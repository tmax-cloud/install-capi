## Make image dir for download capi, aws images
if [ ! -d img ]; then
   mkdir img
fi

## Pull image: kube-rbac-proxy
docker pull gcr.io/kubebuilder/kube-rbac-proxy:$KUBE_RBAC_PROXY_VERSION 
docker save gcr.io/kubebuilder/kube-rbac-proxy:$KUBE_RBAC_PROXY_VERSION > img/kubebuilder_kube-rbac-proxy_$KUBE_RBAC_PROXY_VERSION.tar 

## Pull images: 1.cluster-api-components.yaml
docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/cluster-api-controller:$CAPI_VERSION
docker save us.gcr.io/k8s-artifacts-prod/cluster-api/cluster-api-controller:$CAPI_VERSION > img/cluster-api_cluster-api-controller_$CAPI_VERSION.tar

docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:$CAPI_VERSION
docker save us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-bootstrap-controller:$CAPI_VERSION > img/cluster-api_kubeadm-bootstrap-controller_$CAPI_VERSION.tar

docker pull us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:$CAPI_VERSION
docker save us.gcr.io/k8s-artifacts-prod/cluster-api/kubeadm-control-plane-controller:$CAPI_VERSION > img/cluster-api_kubeadm-control-plane-controller_$CAPI_VERSION.tar

## Pull images: 3.control-plane-components.yaml
docker pull us.gcr.io/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:$AWS_VERSION
docker save us.gcr.io/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:$AWS_VERSION > img/cluster-api-aws_cluster-api-aws-controller_$AWS_VERSION.tar

## Download binary files and yaml files
curl -L http://github.com/kubernetes-sigs/cluster-api/releases/download/"$CAPI_VERSION"/cluster-api-components.yaml > yaml/_template/cluster-api-components-template-${CAPI_VERSION}.yaml 
curl -L https://github.com/kubernetes-sigs/cluster-api/releases/download/${CAPI_VERSION}/clusterctl-linux-amd64 -o clusterctl
curl -L https://github.com/jetstack/cert-manager/releases/download/${CERT_MANAGER_VERSION}/cert-manager.yaml -o cert-manager-${CERT_MANAGER_VERSION}.yaml
curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/clusterawsadm-linux-amd64 -o clusterawsadm