source version.conf

## Register images to registry
sudo docker load < img/cluster-api-aws_cluster-api-aws-controller_${AWS_VERSION}.tar
sudo docker tag us.gcr.io/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION} ${REGISTRY}/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}
sudo docker push ${REGISTRY}/k8s-artifacts-prod/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}

## Change image registry
sed -i 's/gcr.io\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/'"${REGISTRY}"'\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/'"${REGISTRY}"'\/k8s-artifacts-prod\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml

bash message.sh "SUCCESS" "run 'bash 2.1.install-aws.sh'"
