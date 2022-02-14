# Create service and webapp
    helm upgrade --install org1 charts/service
    helm upgrade --install org1 charts/webapp

# Replace url webapp
    helm upgrade --install --set ingress.hosts[0].host=org1.wehost.asia org1 charts/webapp
