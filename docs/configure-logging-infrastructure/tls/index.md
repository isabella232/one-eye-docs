---
title: TLS-encrypted log transfer
shorttitle: TLS encryption
weight: 800
aliases:
    - /docs/one-eye/tls/
---

One Eye can automatically encrypt the communication between Fluentd and Fluent Bit, and it also automates handling the certificates used to mutually authenticate the TLS connections using [cert-manager](https://cert-manager.io/).

To enable TLS encryption between Fluentd and Fluent Bit, complete the following steps.

1. Install the cert-manager component of One Eye.

    ```bash
    one-eye cert-manager install
    ```

1. Update the logging component.

    ```bash
    one-eye logging install --update
    ```

1. Enable encrypted log transfer. The following command creates the required certificates and configures the Logging resource accordingly.

    ```bash
    one-eye logging configure --secure
    ```

1. One Eye automatically creates the custom resources required for TLS certificates. Additionally, the generated configuration include newly created secrets for Fluentd and Fluent Bit. For example:

    ```yaml
    apiVersion: logging.banzaicloud.io/v1beta1
    kind: Logging
    metadata:
    name: one-eye
    spec:
    enableRecreateWorkloadOnImmutableFieldChange: true
    controlNamespace: default
    fluentbit:
        tls:
        enabled: true
        secretName: one-eye-fluentbit-secret
    ...`
    fluentd:
        tls:
        enabled: true
        secretName: one-eye-fluentd-secret
        image:
        tag: v1.9.2-alpine-9
        repository: banzaicloud/one-eye-fluentd
        disablePvc: true
    ```
