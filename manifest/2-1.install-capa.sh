if [ ! -f "aws-credential.conf" ]; then
    bash message.sh "ERROR" "'aws-credential.conf' is NOT EXIST!"
    exit 0
fi


source aws-credential.conf

cat << EOF | base64 | tr '\n' ' ' | sed 's/ //g' > tmp.txt
[default]
aws_access_key_id = $AWS_ACCESS_KEY
aws_secret_access_key = $AWS_SECRET_ACCESS_KEY
region = $AWS_REGION
EOF

export AWS_B64ENCODED_CREDENTIALS=$(cat tmp.txt)

envsubst < capa/infrastructure-components.yaml | kubectl apply -f -
kubectl apply -f capa/certificate.yaml