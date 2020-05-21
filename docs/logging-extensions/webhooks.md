---
title: Logging extensions file tailer webhook
weight: 1000
---

## Logging extensions file tailer webhook

### Introduction

Another way to keep your custom file's content tailed aside of [`host file tailer`](../#host-file-tailer) service, to configure and use the `file tailer webhook` service.
While the containers of the `host file tailers` run in a separated pod, `file tailer webhook` uses a different approach, it injects a sidecar container for every tailed file into your pod, triggered by a simple pod annotation.

---
### Installation
The only thing you need is to provide valid TLS certificates to the `file tailer webhook`. 

There are three possible ways to do this:
* install `cert-manager` with one-eye
* use your own `cert-manager` service
* provide valid secrets and ca bundle by your own

#### Install with cert-manager:
[`One-eye`](https://banzaicloud.com/products/one-eye/) offers a [`cert-manager`](https://cert-manager.io/) installation with `file tailer webhook` by default. We belive that the `cert-manager` is a powerful tool, so we strongly recommend to use it.
```bash
one-eye-cli logging install --enable-filetailer-webhook
```

#### Install without cert-manager:
You can skip the default `cert-manager` installation process by extending the installation parameters with: 
```bash
one-eye-cli logging install --enable-filetailer-webhook --no-cert-manager
```
> Hints:
> * If there is no existing `cert-manager` on your cluster, and there won't be secret and cabundle parameters provided, the install will fail.

#### Provide your own secrets:
When you have your own certifications set up, you can pass them to the installer to configure `file tailer webhook` to use them. In this case there is no need to use `cert-manager`, so the required arguments are the following:
```bash
one-eye-cli logging install --enable-filetailer-webhook --no-cert-manager --webhook-secret <secret name> --webhook-cabundle <CA bundle>
```

###### Example:

1. Let's assume you have your own certs generated in /tmp

2. Make your own secret with your serving certs
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

3. Install logging with your secret name and rootCA information provided
```bash
one-eye-cli logging install --namespace ${namespace} --enable-filetailer-webhook --no-cert-manager --webhook-secret "my-own-certs" --webhook-cabundle "$(cat /tmp/rootCA.pem)"
```

> Hints:
> - Certs must allow one-eye-tailer-webhook, one-eye-tailer-webhook.namespace, one-eye-tailer-webhook.namespace.svc.

---
### Triggering the webhook
`File tailer webhook` is based on a [`Mutating Admission Webhook`](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) which gets called every time, when a pod starts, and will be triggered when a pod specification contains annotation with the key:
- `sidecar.logging-extensions.banzaicloud.io/tail`.

###### Example:
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

### About the File Tailer Webhook annotation
The basic format of a `file tailer webhook` annotation is the following:

|||
|---|---|
| Key | `sidecar.logging-extensions.banzaicloud.io/tail` |
| Value | Files to be tailed separated by commas |

###### Example:
```bash
...
metadata:
    name: test-pod
    annotations: {"sidecar.logging-extensions.banzaicloud.io/tail": "/var/log/date,/var/log/mycustomfile"}
spec:
...
```

### Mutli-container pods
In some cases you have multiple containers in your pod and you want to distinguish which file annotation belongs to which container. You can order every file annotations to particular container by prefixing the annotation with a `${ContainerName}:` container key.

###### Example:
```bash
...
metadata:
    name: test-pod
    annotations: {"sidecar.logging-extensions.banzaicloud.io/tail": "sample-container:/var/log/date,sample-container2:/var/log/anotherfile,/var/log/mycustomfile,foobarbaz:/foo/bar/baz"}
spec:
...
```

| Annotation | Explanation |
|---|---|
| sample-container:/var/log/date | tails file /var/log/date in sample-container |
| sample-container2:/var/log/anotherfile |  tails file /var/log/anotherfile in sample-container2 |
| /var/log/mycustomfile | tails file /var/log/mycustomfile in default container (sample-container) |
| foobarbaz:/foo/bar/baz | will be discarded due to non-existing container name |

> Hints:
> - Annotations without containername prefix: the file gets tailed on the default container (container 0)
> - Annotations with invalid containername: file tailer annotation gets discarded
