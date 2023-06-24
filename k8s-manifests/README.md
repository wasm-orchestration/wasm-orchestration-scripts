# Kubernetes Manifests

Manifest files required for replicating the Kubernetes benchmarking environment.

## Calico

1. To deploy Calico CNI after K3s has been installed, edit `calico.yaml`, replacing the value of the `CALICO_IPV4POOL_CIDR` environment variable with the CIDR range passed as `--cluster-cidr` during the deployment of K3s. If the instructions from the root of the repository have been followed, no manual changes are required.
2. Execute:

    ```bash
    kubectl create -f kube-system/calico.yaml --save-config
    ```

3. After Calico's deployment all Kubernetes nodes should tranisition to a `Ready` state, which can be verified with `kubectl get node`.

## Helm

```bash
cd $(mktemp -d)
wget https://get.helm.sh/helm-v3.11.0-linux-amd64.tar.gz
tar -xvzf helm-v3.11.0-linux-amd64.tar.gz --strip-components=1
chown root:root helm
mv helm /usr/local/bin
```

## MetalLB

```bash
kubectl create -f metallb/metallb-system.namespace.yaml --save-config
helm repo add metallb https://metallb.github.io/metallb
helm install metallb -n metallb-system metallb/metallb
# edit metallb/default-pool.ipaddresspool.yaml, reserving an IP range from the local subnet for use with MetalLB
kubectl create -f metallb/default-pool.ipaddresspool.yaml --save-config
kubectl create -f metallb/default-pool.l2advertisement.yaml --save-config
```

## Ingress-Nginx

```bash
kubectl create namespace ingress-nginx
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm install ingress-nginx --namespace ingress-nginx -f ingress-nginx/values.yaml ingress-nginx/ingress-nginx
```

## Spin (WebAssembly) Runtime Class

```bash
kubectl create -f kube-system/spin.runtimeclass.yaml --save-config
kubectl label nodes my-node01 mrezhi.net/webassembly-runtime=true
```

## OpenFaaS

```bash
kubectl create -f openfaas/openfaas.namespace.yaml --save-config
helm repo add openfaas https://openfaas.github.io/faas-netes/
helm install openfaas --namespace openfaas -f openfaas/values.yaml openfaas/openfaas
kubectl create -f openfaas/openfaas-prometheus.ingress.yaml --save-config
kubectl create -f openfaas/openfaas-alertmanager.ingress.yaml --save-config
# acquire admin password
echo $(kubectl -n openfaas get secret basic-auth -o jsonpath="{.data.basic-auth-password}" | base64 --decode)
```