kubectl --namespace=default get secret "${CLUSTER_NAME}"-kubeconfig \
    -o jsonpath={.data.value} | base64 --decode \
    > "${CLUSTER_NAME}".kubeconfig

kubectl --kubeconfig="${CLUSTER_NAME}".kubeconfig apply -f https://docs.projectcalico.org/v3.15/manifests/calico.yaml