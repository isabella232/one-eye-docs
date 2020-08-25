---
title: Install the webhook
shorttitle: Install
weight: 100
---

The only thing you need is to provide valid TLS certificates to the `file tailer webhook`. 

There are three possible ways to do this:

* Install `cert-manager` with one-eye
* Use an already installed `cert-manager` service
* [Provide your own secrets and CA bundle](#own-secrets)

## Install with cert-manager {#cert-manager}

You can install [`cert-manager`](https://cert-manager.io/) with the [`one-eye`](/products/one-eye/) command-line tool. The `cert-manager` is a powerful tool, so we strongly recommend to use it. Complete the following steps.

1. First, install cert-manager. If `cert-manager` is already installed on your cluster, you can skip this step and use the existing installation.

    ```bash
    one-eye-cli cert-manager install
    ```

1. Install the webhook:

    ```bash
    one-eye-cli tailer-webhook install
    ```

    If `cert-manager` is not installed on your cluster, and you haven't provided the secret and cabundle parameters, the install will fail.

## Provide your own secrets {#own-secrets}

When you have your own certificates set up, you can pass them to the installer to configure `file tailer webhook` to use them. In this case there is no need to use `cert-manager`.
The required arguments are the following:

```bash
one-eye-cli tailer-webhook install --webhook-secret <secret name> --webhook-cabundle <CA bundle>
```

To create the secret and the CA bundle, complete the following procedure.

1. Let's assume you have your own certs generated in /tmp

2. Make your own secret with your certificates:

    ```bash
    kubectl apply -f - <<EOF
    apiVersion: v1
    kind: Secret
    metadata:
    name: "my-own-certs"
    namespace: ${namespace}
    data:
    tls.crt: $(cat /tmp/tls.crt | base64)
    tls.key: $(cat /tmp/tls.key | base64)
    type: kubernetes.io/tls
    EOF
    ```

3. Install the webhook with your secret name and rootCA information provided:

    ```bash
    one-eye-cli tailer-webhook install --namespace ${namespace} --webhook-secret "my-own-certs" --webhook-cabundle "$(cat /tmp/rootCA.pem)"
    ```

> Hints:
> - Certs must allow one-eye-tailer-webhook, one-eye-tailer-webhook.namespace, one-eye-tailer-webhook.namespace.svc.
