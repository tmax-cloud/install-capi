if [ ! -f "registry.conf" ]; then
    bash message.sh "ERROR" "'registry.conf' is NOT EXIST!"
    exit 0
fi

source registry.conf
source version.conf

## Change image registry
FILE=capa/infrastructure-components.yaml
sed -i 's/registry.k8s.io\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/'"${REGISTRY}"'\/cluster-api-aws\/cluster-api-aws-controller:'"${AWS_VERSION}"'/g' $FILE