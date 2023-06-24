# WASM Orchestration Scripts Repository

# Installation Instructions

## Kubernetes Cluster Deployment

### Master Node

```bash
export INSTALL_K3S_VERSION=v1.22.17+k3s1
curl -sfL https://get.k3s.io | sh -s - server \
  --node-taint CriticalAddonsOnly=true:NoExecute \
  --tls-san cluster.example.com \
  --tls-san 10.10.10.10 \
  --disable=traefik \
  --flannel-backend=none \
  --disable-network-policy \
  --disable=servicelb \
  --write-kubeconfig-mode 664 \
  --cluster-cidr=10.136.0.0/16
```

The above command will deploy a master node with the following configuration:
- `--node-taint CriticalAddonsOnly=true:NoExecute` – the master node will not run any user workloads.
- `--tls-san` – Subject Alternate Name (SAN) for the generated Kubernetes certificates. Replace with the IP address of the master node(s). If a hostname is assigned, make sure to include the hostname as well.
- `--disable=traefik` – don't use Traefik as the ingress controller. We will be using nginx instead.
- `--flannel-backend=none` – don't use Flannel as the Container Networking Interface (CNI) plugin. We will be using Calico instead.
- `--disable-network-policy` – disable the network policy plugin. Calico has built-in support for Kubernetes NetworkPolicy objects.
- `--disable=servicelb` – disable the load-balancer plugin. We will be using MetalLB instead.
- `--write-kubeconfig-mode 664` – file permissions for the created `.kube/config` file, containing information to connect to the cluster.
- `--cluster-cidr=10.136.0.0/16` – the Kubernetes Pod subnet range. Must not override with existing subnets in the network.

### Worker nodes

```bash
export INSTALL_K3S_VERSION=v1.22.17+k3s1
curl -sfL https://get.k3s.io | K3S_URL=https://10.10.10.10:6443 K3S_TOKEN=$CHANGE_ME sh -s -
```

Replace the value of the `K3S_URL` variable with the IP address of a master node. Replace the value of the `K3S_TOKEN` variable with the contents of the `/var/lib/rancher/k3s/server/node-token` file.

## Shim Deployment

1. Refer to the insturctions available in the [wasm-orchestration/containerd-spin-shim](https://github.com/wasm-orchestration/containerd-spin-shim) repository regarding customizing the source code and building the contantainerd spin shim binary.
2. Once the binary is built, transfer it to `/usr/local/bin` directory on the Kubernetes worker nodes (the full path should be `/usr/local/bin/containerd-shim-spin-v1`).
3. K3s uses a scoped containerd, so a symlink needs to be created:

    ```bash
    ln -s /usr/local/bin/containerd-shim-spin-v1 /var/lib/rancher/k3s/data/current/bin/containerd-shim-spin-v1
    ```

4. Add support for the new shim by customizing the `containerd.toml` file:
    - Create the file `/var/lib/rancher/k3s/agent/etc/containerd/config.toml.tmpl` with the following content:

      ```toml
      [plugins.opt]
        path = "/var/lib/rancher/k3s/agent/containerd"

      [plugins.cri]
        stream_server_address = "127.0.0.1"
        stream_server_port = "10010"
        enable_selinux = false
        sandbox_image = "rancher/mirrored-pause:3.6"

      [plugins.cri.containerd]
        snapshotter = "overlayfs"
        disable_snapshot_annotations = true



      [plugins.cri.containerd.runtimes.runc]
        runtime_type = "io.containerd.runc.v2"

      [plugins.cri.containerd.runtimes.spin]
        runtime_type = "io.containerd.spin.v1"

      [plugins.cri.containerd.runtimes.runc.options]
              SystemdCgroup = true
      ```
    - Restart k3s or reboot the worker node.

## Kubernetes Runtime Class Deployment

To be able to leverage the new Spin runtime, a Kubernetes RuntimeClass object needs to be created:

```yaml
apiVersion: node.k8s.io/v1
handler: spin
kind: RuntimeClass
metadata:
  name: spin
scheduling:
  nodeSelector:
    kubernetes.io/hostname: l26-lab80-kw01
```

In a real-world environment it is expected that not all nodes will be capable of executing WebAssembly workloads. To restrict the set of nodes which can run Pods that have the `spin` RuntimeClass assigned, [nodeSelectors](https://kubernetes.io/docs/concepts/scheduling-eviction/assign-pod-node/) can be used.

## Kubernetes WebAssembly Operator Deployment

See [wasm-orchestration/wasm-operator](https://github.com/wasm-orchestration/wasm-operator)

## Custom Version of K3s

To install the custom version of K3s which can offer granular timestamps for all pod events, follow the instructions on [wasm-orchestration/k3s-kubernetes](https://github.com/wasm-orchestration/k3s-kubernetes) for modifying the base Kubernetes components, and once a new release is created, edit the dependencies list in the `go.mod` file available in [wasm-orchestration/k3s](https://github.com/wasm-orchestration/k3s), before following the compilation instructions. The resulting K3s binary can be used in place of the original K3s binary on the Kubernetes nodes (`/usr/local/bin/k3s` and `/usr/local/bin/k3s-agent`).

# Functions Deployment

Each function in the `functions/` folder has a `build.sh` script capable of building an OCI image and pushing it to an OCI image registry. Edit the parameters in the build script to correspond to your environment and available resources. Once an OCI image is built, the functions can be instantiated in the cluster by creating the relevant `WasmApp` manifests available in `k8s-manifests/WasmApps` (in the case of WASM Spin) or by using [faas-cli](https://docs.openfaas.com/cli/install/) and the relevant `faas-cli build` and `faas-cli up` commands.
