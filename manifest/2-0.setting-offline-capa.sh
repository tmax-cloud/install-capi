if [ ! -f "registry.conf" ]; then
    bash message.sh "ERROR" "'registry.conf' is NOT EXIST!"
    exit 0
fi

source registry.conf
source version.conf

## Register images to registry
sudo docker load < img/cluster-api-aws_cluster-api-aws-controller_${AWS_VERSION}.tar
TARGET=${REGISTRY}/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION}
sudo docker tag registry.k8s.io/cluster-api-aws/cluster-api-aws-controller:${AWS_VERSION} $TARGET
sudo docker push $TARGET

## Change image registry
CP_FILE=capa/offline-infrastructure-components.yaml
cp capa/infrastructure-components.yaml $CP_FILE
sed -i 's/registry.k8s.io\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/'"${REGISTRY}"'\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/g' $CP_FILE