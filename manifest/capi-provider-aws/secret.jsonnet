apiVersion: v1
data:
  credentials: params.credentials
kind: Secret
metadata:
  labels:
    cluster.x-k8s.io/provider: infrastructure-aws
  name: capa-manager-bootstrap-credentials
  namespace: capa-system
type: Opaque