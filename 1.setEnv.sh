export CAPI_VERSION=v0.3.6
export AWS_VERSION=v0.5.5-alpha.0
export KUBE_RBAC_PROXY_VERSION=v0.4.1

## mkdir
#### make yaml dir
if [ ! -d yaml ]; then
    mkdir yaml
    mkdir yaml/_template
    mkdir yaml/_install
fi

#### make image dir for download capi, aws images
if [ ! -d img ]; then
   mkdir img
fi