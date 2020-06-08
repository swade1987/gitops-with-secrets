# Pre-requisites

## k3d

The demo uses [rancher/k3d](https://github.com/rancher/k3d) to spin up a cluster locally.

The installation guide for `k3d` can be found [here](https://github.com/rancher/k3d#get).

## Helm 3

Flux is installed using [Helm 3](https://helm.sh/blog/helm-3-released/).

The installation guide for this can be found [here](https://helm.sh/docs/intro/install/). 

## Kubeseal

Kubeseal is a binary which is used to sealed Kubernetes secret using the environments public key.

To download Kubeseal simply execute the following command:

```
make init
```