---
title: Quickstart
weight: 50
---



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

You will need an object store. Thanos supports many types of object storage, see the [official Thanos documentation](https://thanos.io/tip/thanos/storage.md/) for details.

### Install the One Eye tool

Install the One Eye command-line tool. You can use the One Eye CLI tool to install One Eye and other components to your cluster.
> Note: The One Eye CLI supports macOS and Linux (x86_64). It may work on Windows natively, but we don't test it.

1. [Register for an evaluation version](/products/try-one-eye/).
1. Install the `one-eye-cli` package for your environment by running the following command:

    ```bash
    curl https://getoneeye.sh | sh
    ```

    For other options, see the [One Eye CLI Installation Guide](../cli/install/).

{{% include-headless "doc/quickstart-set-kubernetes-context.md" %}}

## Deploy One Eye

After you have completed the [Prerequisites](#prerequisites), you can install One Eye on a single cluster.

1. The following command installs the *[Logging Operator](/docs/one-eye/logging-operator/)*, the *[Logging Extension](https://banzaicloud.com/docs/one-eye/logging-extensions/)*, a *Prometheus Operator*, and all dependencies.

    ```bash
    one-eye logging install --prometheus
    ```

    During the interactive mode, the One Eye CLI will ask for the name of the object storage and the associated secrets.

1. Wait a few minutes and verify that the components are installed.

    ```bash
    $ kubectl get po
    NAME                                                             READY   STATUS    RESTARTS   AGE
    alertmanager-one-eye-prometheus-operato-alertmanager-0           2/2     Running   0          3m3s
    one-eye-logging-extensions-f8599dd6f-kmd2x                       1/1     Running   0          107s
    one-eye-logging-operator-f7c679745-7dmk5                         1/1     Running   0          114s
    one-eye-prometheus-operato-operator-5d5c4fcfdc-t6lvl             2/2     Running   0          3m15s
    one-eye-prometheus-operator-grafana-76c45c5559-whhlf             2/2     Running   0          3m15s
    one-eye-prometheus-operator-kube-state-metrics-f45595f4c-w5w2z   1/1     Running   0          3m15s
    one-eye-prometheus-operator-prometheus-node-exporter-qplrd       1/1     Running   0          3m15s
    prometheus-one-eye-prometheus-operato-prometheus-0               4/4     Running   1          2m53s
    ```

    You should see that the three operators are running.

    > To repeat the installation process, just append the `one-eye logging install --prometheus --update` command.
1. Configure a simple logging system. Run the following command and follow the on-screen instructions.

    ```bash
    $ one-eye logging configure
    ? Configure persistent volume for buffering logs? No
    #
    apiVersion: logging.banzaicloud.io/v1beta1
    kind: Logging
    metadata:
    name: one-eye
    spec:
    enableRecreateWorkloadOnImmutableFieldChange: true
    controlNamespace: default
    fluentbit:
        metrics:
    ...
    ? Edit the configuration in an editor? No
    ? Apply the configuration? Yes
    observer> resource created name: ...
    ? Create a new Flow? Yes
    ```

    The CLI will provide a template for the *Logging* resource with some basic configuration.
    You can edit this template and decide to apply it on the cluster or not. After applying
    the logging resource, continue to create an `Output` and a `Flow`.

1. Configure an S3 output. Run the following command and follow the on-screen instructions. (Currently the interactive mode supports only the S3 output, you can [configure other outputs in the Logging operator](/docs/one-eye/logging-operator/).)

    ```bash
    $ one-eye logging configure output
    ? What type of output do you need? s3
    ? Select the namespace for your output default
    ? Use the following name for your output s3
    ? S3 Bucket banzai-one-eye
    ? Region of the bucket eu-west-1
    ? Configure authentication based on your current AWS credentials? Yes
    ? Save AKIXXXXXXXXXXXXXXXX to a Kubernetes secret and link it with the output Yes
    # Copyright © 2020 Banzai Cloud
    apiVersion: logging.banzaicloud.io/v1beta1
    kind: Output
    metadata:
    name: s3
    namespace: default
    spec:
    # Reference docs for the output configuration:
    #   https://banzaicloud.com/docs/one-eye/logging-operator/plugins/outputs/s3
    s3:
        s3_bucket: banzai-one-eye
        s3_region: eu-west-1
        path: logs/${tag}/%Y/%m/%d/
        aws_key_id:
        valueFrom:
            secretKeyRef:
            name: s3-6bcf
            key: awsAccessKeyId
        aws_sec_key:
        valueFrom:
            secretKeyRef:
            name: s3-6bcf
            key: awsSecretAccessKey
    ? Edit the configuration in an editor? No
    ? Apply the configuration? Yes
    observer> resource created name: s3...
    ```

    If you have your Amazon credential configured in your environment, the CLI will ask if you want to use them to access the bucket. When you choose *yes* the CLI will automatically create a Kubernetes secret with your Amazon Key and Secret. After specifying the bucket name and region the generated template is ready to be used (or customized). It includes the secret name and bucket information as well.

    > Note: For details on configuring different output types, see the {{% xref "/docs/one-eye/logging-operator/quickstarts/_index.md" %}}.

1. Configure a logging flow. The basic template provides an empty flow. Customize the `match` section and add filters from the [supported filter list](/docs/one-eye/logging-operator/plugins/filters/).

    ```bash
    $ one-eye logging configure flow
    ? Select the namespace for your flow default
    Available Outputs: [s3]
    ? Select an output s3
    ? Give a name for your flow my-flow
    #
    apiVersion: logging.banzaicloud.io/v1beta1
    kind: Flow
    metadata:
    name: my-flow
    namespace: default
    spec:
    filters:
    # tag normalizer changes default kubernetes tags coming from fluentbit to the following format: namespace.pod.container
    # https://banzaicloud.com/docs/one-eye/logging-operator/plugins/filters/tagnormaliser/
    - tag_normaliser: {}
    match:
    # a select without restrictions will forward all events to the outputRefs
    - select: {}
    outputRefs:
        - s3
    ? Edit the configuration in an editor? No
    ? Apply the configuration? Yes
    observer> resource created name: my-flow...
    ```

    After applying the yaml, the logs are flowing to the S3 bucket.

## Display the logging flow

In real-life scenarios you have several flows and outputs for different purposes. One Eye helps you review your logging infrastructure by visualizing it. Complete the following steps.

1. Install the [One Eye](/products/one-eye/) UI. The following command installs an `nginx` ingress and the [One Eye](/products/one-eye/) UI. This ingress is exposed to localhost by default, but you can connect to it via One Eye.

    ```bash
    $ one-eye ingress install --update
    ```

1. Connect to the One Eye Dashboard and review your logging infrastructure.

    ```bash
    one-eye ingress connect
    ```

    The [One Eye UI](/docs/one-eye/configuration-overview/) opens in your browser.
    ![One Eye Dashboard](/docs/one-eye/configure-logging-infrastructure/configuration-overview/overview-nocallouts.png)
