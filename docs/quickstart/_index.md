---
title: Quickstart
weight: 50
---

{{< contents >}}

To **evaluate** the services [Banzai Cloud One Eye](/products/one-eye/) (One Eye) offers, we recommend to create a test environment.
This way you can start over any time, and try all the options you are interested in without having to worry about changes made to your existing environment, even if it's not used in production.

**Production installation** is very similar, but you must exactly specify which components you want to use.

## Prerequisites

Before deploying One Eye on your cluster, complete the following tasks.

### Create a test cluster

You need a Kubernetes cluster to test One Eye with. If you don't already have a Kubernetes cluster to work with, create one with one of the following methods:

- You can use the [self-hosted](../../pipeline/quickstart/install-pipeline/) or the [free online](../../pipeline/quickstart/install-pipeline/try/) version of Banzai Cloud Pipeline to [deploy a cluster](../../pipeline/quickstart/create-cluster/).
- Deploy a [single-node](../../pke/quickstart/single/) Banzai Cloud PKE cluster on a physical or virtual Linux box.
- Launch a cluster at one of the many cloud providers' managed offerings at their console.
- Use [KinD](https://kind.sigs.k8s.io/docs/user/quick-start/) on your machine (make sure to increase the resource allocation of Docker for Mac).

### Create an object store

You will need an object store. Thanos supports many types of object storage, see the [official Thanos documentation](https://thanos.io/storage.md/) for details.

### Install the One Eye tool

Install the One Eye command-line tool. You can use the One Eye CLI tool to install One Eye and other components to your cluster.
> Note: The One Eye CLI supports macOS and Linux (x86_64). It may work on Windows natively, but we don't test it.

The quickest way to install the `one-eye-cli` package for your environment is to run the following command:

```bash
curl https://getoneeye.sh | sh
```

For other options, see the [One Eye CLI Installation Guide](../cli/install/).

{{% include-headless "doc/quickstart-set-kubernetes-context.md" %}}

## Deploy One Eye

After you have completed the [Prerequisites](#prerequisites), you can install One Eye on a single cluster.

To install Thanos interactively, run

```bash
one-eye thanos install --prometheus
```

During the interactive mode, the One Eye CLI will ask for the name of the object storage and the associated secrets, and will install Thanos and all dependencies (for example, Prometheus).
