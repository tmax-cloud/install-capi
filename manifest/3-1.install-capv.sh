if [ ! -f "vsphere-credential.conf" ]; then
    bash message.sh "ERROR" "'vsphere-credential.conf' is NOT EXIST!"
    exit 1
fi

source vsphere-credential.conf

envsubst < capv/infrastructure-components.yaml | kubectl apply -f -