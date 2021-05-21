source version.conf

## Register images to registry
sudo docker load < img/cluster-api-aws_cluster-api-aws-controller_${AWS_VERSION}.tar
sudo docker tag gcr.io/k8s-staging-cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION} ${REGISTRY}/k8s-staging-cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}
sudo docker push ${REGISTRY}/k8s-staging-cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}

## Change image registry
sed -i 's/gcr.io\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/'"${REGISTRY}"'\/kubebuilder\/kube-rbac-proxy:'"${KUBE_RBAC_PROXY_VERSION}"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml
sed -i 's/gcr.io\/k8s-staging-cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/'"${REGISTRY}"'\/k8s-staging-cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/g' yaml/infrastructure-components-aws-${AWS_VERSION}.yaml

echo ""
echo ""
echo "########################################################################################"
echo "COMPLETE PRESET!!!!! GO TO NEXT STEP"
echo ""
echo ""