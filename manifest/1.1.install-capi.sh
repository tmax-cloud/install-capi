if [ ! -f "oidc.conf" ]; then
    bash message.sh "ERROR" "'oidc.conf' is NOT EXIST!"
    exit 0
fi

source version.conf
source oidc.conf

## Exception case handling for oidc configuration
sudo cp ${OIDC_CA_FILE} ./target.crt
sed -i 's/^/          /' ./target.crt
url_for_sed=$(echo ${OIDC_ISSUER_URL} | sed 's/\//\\\//g')
file_for_sed=$(echo ${OIDC_CA_FILE} | sed 's/\//\\\//g')

## Set oidc configuration to templates
sed -i 's/${OIDC_ISSUER_URL}/'"${url_for_sed}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_CLIENT_ID}/'"${OIDC_CLIENT_ID}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_USERNAME_CLAIM}/'"${OIDC_USERNAME_CLAIM}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_USERNAME_PREFIX}/'"${OIDC_USERNAME_PREFIX}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_GROUPS_CLAIM}/'"${OIDC_GROUPS_CLAIM}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sed -i 's/${OIDC_CA_FILE}/'"${file_for_sed}"'/g' yaml/service-catalog-template-CAPI-*.yaml
sudo sed -i -e '/${HYPERAUTH_CERT}/r target.crt' -e '/${HYPERAUTH_CERT}/d' yaml/service-catalog-template-CAPI-*.yaml
#sed -i ${HYPERAUTH_CERT} yaml/service-catalog-template-CAPI-*.yaml
#sed -i 's/\\n/\'$'\n''/g' yaml/service-catalog-template-CAPI-*.yaml

## Download and provision CAPI
kubectl apply -f yaml/cluster-api-components-${CAPI_VERSION}.yaml

rm -f ./target.crt

bash ./message.sh "SUCCESS" "see 'kubectl get pods -A | grep capi'"