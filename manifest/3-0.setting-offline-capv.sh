if [ ! -f "registry.conf" ]; then
    bash message.sh "ERROR" "'registry.conf' is NOT EXIST!"
    exit 0
fi

source registry.conf
source version.conf

## Change image registry

FILE=capv/infrastructure-components.yaml
sed -i 's/gcr.io\/cluster-api-provider-vsphere\/release\/manager:'"${VSPHERE_VERSION}"'/'"${REGISTRY}"'\/cluster-api-provider-vsphere\/release\/manager:'"${VSPHERE_VERSION}"'/g' $FILE