---
title: Logging extensions file tailer webhook
shorttitle: File tailer webhook
weight: 1000
---

{{< contents >}}

Another way to keep your custom file's content tailed aside of [`host file tailer`](../#host-file-tailer) service, to configure and use the `file tailer webhook` service.
While the containers of the `host file tailers` run in a separated pod, `file tailer webhook` uses a different approach, it injects a sidecar container for every tailed file into your pod, triggered by a simple pod annotation.

## Install the webhook

The only thing you need is to provide valid TLS certificates to the `file tailer webhook`. 

There are three possible ways to do this:

* Install `cert-manager` with one-eye
* Use an already installed `cert-manager` service
* [Provide your own secrets and CA bundle](#own-secrets)

### Install with cert-manager {#cert-manager}

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

### Provide your own secrets {#own-secrets}

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

## Triggering the webhook

`File tailer webhook` is based on a [`Mutating Admission Webhook`](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) which gets called every time when a pod starts, and will be triggered when a pod specification contains an annotation with the `sidecar.logging-extensions.banzaicloud.io/tail` key. For example:

```bash
apiVersion: v1
kind: Pod
metadata:
    name: test-pod
    annotations: {"sidecar.logging-extensions.banzaicloud.io/tail": "/var/log/date"}
spec:
    containers:
    - image: debian
        name: sample-container
        command: ["/bin/sh", "-c"]
        args:
            - while true; do
                date >> /var/log/date;
                sleep 1;
        done
    - image: debian
        name: sample-container2
...
```

> Note: if the pod contains multiple containers, see [Multi-container pods](#multi-container-pods).

### About the File Tailer Webhook annotation

The basic format of a `file tailer webhook` annotation is the following:

|||
|---|---|
| Key | `sidecar.logging-extensions.banzaicloud.io/tail` |
| Value | Files to be tailed separated by commas |

For example:

```bash
...
metadata:
    name: test-pod
    annotations: {"sidecar.logging-extensions.banzaicloud.io/tail": "/var/log/date,/var/log/mycustomfile"}
spec:
...
```

### Multi-container pods

In some cases you have multiple containers in your pod and you want to distinguish which file annotation belongs to which container. You can order every file annotations to particular container by prefixing the annotation with a `${ContainerName}:` container key. For example:

```bash
...
metadata:
    name: test-pod
    annotations: {"sidecar.logging-extensions.banzaicloud.io/tail": "sample-container:/var/log/date,sample-container2:/var/log/anotherfile,/var/log/mycustomfile,foobarbaz:/foo/bar/baz"}
spec:
...
```

{{< warning >}}
- Annotations without containername prefix: the file gets tailed on the default container (container 0)
- Annotations with invalid containername: file tailer annotation gets discarded
{{< /warning >}}

| Annotation | Explanation |
|---|---|
| sample-container:/var/log/date | tails file /var/log/date in sample-container |
| sample-container2:/var/log/anotherfile |  tails file /var/log/anotherfile in sample-container2 |
| /var/log/mycustomfile | tails file /var/log/mycustomfile in default container (sample-container) |
| foobarbaz:/foo/bar/baz | will be discarded due to non-existing container name |
