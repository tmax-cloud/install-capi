if [ $# -ne 1 ]; then
    echo -e "\nNeeds argument: Network Type(-o/-c)\n"
    return -1
fi

if [ $1 != "-o" ] && [ $1 != "-c" ]; then
    echo -e "\nInvalid argument: can use(-o/-c)\n"
    return -1
fi

## Download clusterawsadm
if [ $1 = "-o" ]; then
    curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/clusterawsadm-linux-amd64 -o clusterawsadm
    chmod +x clusterawsadm
    sudo mv clusterawsadm /usr/local/bin/clusterawsadm
else
    sudo cp $FILE_DIR/bin/clusterawsadm /usr/local/bin/clusterawsadm
fi

## Initialize aws cloudformationstack and credential
clusterawsadm bootstrap iam create-cloudformation-stack
export AWS_B64ENCODED_CREDENTIALS=$(clusterawsadm bootstrap credentials encode-as-profile)

## Download yaml
if [ $1 = "-o" ]; then
    curl -L https://github.com/kubernetes-sigs/cluster-api-provider-aws/releases/download/${AWS_VERSION}/infrastructure-components.yaml > yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml
else
    sudo cp $FILE_DIR/yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml
    sed -i 's/gcr.io\/kubebuilder\/kube-rbac-proxy':${KUBE_RBAC_PROXY_VERSION}'/'${REGISTRY}'\/kubebuilder\/kube-rbac-proxy':${KUBE_RBAC_PROXY_VERSION}'/g' yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml
    sed -i 's/us.gcr.io\/k8s-artifacts-prod\/cluster-api-aws\/cluster-api-aws-controller:'${AWS_VERSION}'/'${REGISTRY}'\/k8s-artifacts-prod\/cluster-api-aws\/cluster-api-aws-controller:':${AWS_VERSION}'/g' yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml
fi

## Initialize CAPI-provider-aws settings
cp yaml/_template/infrastructure-components-aws-template-${AWS_VERSION}.yaml yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml
sed -i 's/${AWS_B64ENCODED_CREDENTIALS}/'${AWS_B64ENCODED_CREDENTIALS}'/g' yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml

## Provision aws infrastructure
kubectl apply -f yaml/_install/2.1.infrastructure-components-aws-${AWS_VERSION}.yaml

## Download and apply catalog
if [ $1 = "-o" ]; then
    curl -L https://github.com/tmax/install-capi/releases/download/v0.1.0/service-catalog-template-CAPI-aws.yaml > yaml/_catalog/1.service-catalog-template-CAPI-aws.yaml
else
    sudo cp $FILE_DIR/yaml/_catalog/1.service-catalog-template-CAPI-aws.yaml yaml/_catalog/1.service-catalog-template-CAPI-aws.yaml
fi
kubectl apply -f yaml/_catalog/1.service-catalog-template-CAPI-aws.yaml