# GitOps (with secrets) 🔒

An example repo structure for GitOps using:

- [Flux](https://github.com/fluxcd/flux)
- [Bitnami Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets)

## TL;DR

**Problem:** "I can manage all my Kubernetes config in git, except Secrets."

**Solution:** Encrypt your Secret into a SealedSecret, which is safe to store. The SealedSecret can be decrypted only by the controller running in the target cluster and nobody else (not even the original author) is able to obtain the original Secret from the SealedSecret.

For more information on Sealed Secrets please see [here](https://github.com/bitnami-labs/sealed-secrets).

## How are these deployed to the cluster?

Flux will apply the sealed secret on our cluster and the [Bitnami Sealed Secrets controller](https://github.com/bitnami-labs/sealed-secrets) will then decrypt it into a Kubernetes secret (see below).

![Flux GitOps Example](img/flux-secrets.png?raw=true "Flux GitOps Example")

## Directory structure

```
.
├── keys
│   ├── dev.crt             # The environment specific public key used for sealing secrets.
├── local-sealed            # Kubernetes secrets which have already been sealed.
│   └── dev                 
├── local-toseal            # Kubernetes secrets which are yet to be sealed.
│   └── dev
└── sealed-secrets          # Sealed secrets to be reconciled by flux.
    └── dev
```

## Pre-requisites

A list of pre-requisites can be found [here](docs/pre-reqs.md).

## Setup

1. To configure this to work with your repository first read the steps [here](docs/configuration.md).

2. Create a cluster using `make cluster`

3. Install [Flux](https://github.com/fluxcd/flux) and [Bitnami Sealed Secrets](https://github.com/bitnami-labs/sealed-secrets) using `make install-flux`

4. After following the prompts, flux will establish a connection to your repository and start reconciling.

5. The `sealed-secrets` controller will be deployed to the `kube-system` namespace.

5. You will also need to add the public key from the sealed secrets' controller using `make get-public-key`.

## Usage

The following sections walks through the tests of creating different types of secrets.

### How do I create a generic secret?

[See here](docs/generic-secret-creation.md).

### How can I seal a lot of secrets at once?

To seal secrets for all environments run

```
$ make seal-all
```

### How can I clean out my local directory?

To clean out local secrets for a single environment run:

```
$ make clean-<env>
```

To clean out all local secrets run:

```
$ make clean
```

### How do I tear down the demo?

Simply execute `make destroy`

## Gotchas

### Only .yaml files

Only files in `local-toseal/<env>` which have an extension `.yaml` will be sealed.

### Re-seal whenever there's a change

You can't change the metadata (e.g. namespace) of a sealed secret without re-sealing it since some form of checksum is performed when unsealing on the server, so if you change anything, you need to re-seal properly.
