## 🚀 Istio Commands

### 🔹 Enable & Check Istio Injection

```sh
kubectl label namespace default istio-injection=enabled  # Enable sidecar injection
kubectl get namespace default --show-labels             # Verify label
```

### 🔹 Managing Istio Components

```sh
istioctl install --set profile=demo                     # Install Istio with the demo profile
istioctl upgrade                                        # Upgrade Istio
istioctl verify-install                                 # Verify installation
istioctl manifest generate                              # Generate Kubernetes manifests for Istio
```

### 🔹 Working with Virtual Services

```sh
kubectl apply -f virtual-service.yaml                  # Apply a VirtualService
kubectl get virtualservice                             # List VirtualServices
kubectl delete virtualservice <name>                   # Delete a VirtualService
```

### 🔹 Managing Gateways

```sh
kubectl apply -f gateway.yaml                          # Apply a Gateway
kubectl get gateway                                   # List Gateways
kubectl delete gateway <name>                         # Delete a Gateway
```

### 🔹 Observability & Debugging

```sh
kubectl get pods -n istio-system                      # List Istio system pods
kubectl logs -l istio=pilot -n istio-system           # View Istio control plane logs
istioctl proxy-status                                 # Get proxy status
istioctl analyze                                      # Analyze the current Istio configuration
```
