source vsphere-credential.conf

envsubst < capv/infrastructure-components.yaml | kubectl apply -f -
kubectl apply -f capv/certificate.yaml