---
title: Logging extensions
weight: 500
---

{{< contents >}}

Logging extensions are part of the Banzai Cloud One Eye observability system, and are the commercial extensions of the Logging operator. Logging extensions were specifically developed to solve the problems of enterprises:

- Collecting Kubernetes events to provide insight into what is happening
inside a cluster, such as decisions made by the scheduler, or
why some pods were evicted from the node.
- Collect logs from the nodes like `kubelet` logs.
- Collect logs from files on the nodes, for example, `audit` logs, or the `systemd` journal.

You can configure the extensions in the One Eye custom resource configuration.

> Follow [this guide](/docs/one-eye/cli/install/) to install the One Eye command line tool.

## Quick start with Kubelet and Event logs

1. Create a file named `observer.yaml`

    ```yaml
    apiVersion: one-eye.banzaicloud.io/v1alpha1
    kind: Observer
    metadata:
      name: observer
    spec:
      controlNamespace: default
      logging:
        kubernetesEventTailer: {}
        hostTailers:
          systemdTailers:
            - name: kubelet
              systemdFilter: kubelet.service
          fileTailers:
            - name: messages
              path: /var/log/messages
    ```

1. Apply configuration to the cluster (your current Kubernetes context):

    ```bash
    one-eye reconcile -f observer.yaml
    ```

## Kubernetes Event Tailer

Kubernetes events are objects that provide insight into what is happening
inside a cluster, such as what decisions were made by the scheduler or
why some pods were evicted from the node.

### Example: configuration Kubernetes event tailer

```bash
one-eye reconcile -f - <<EOF
apiVersion: one-eye.banzaicloud.io/v1alpha1
kind: Observer
metadata:
  name: observer
spec:
  controlNamespace: default
  logging:
    kubernetesEventTailer: {}
EOF
```

### Configuration options

| Variable Name | Type | Description |
|---|---|---|
|disabled|`bool`|Disable this component without clearing other configuration options|
|selectorLabels|`map[string]string`|Add the specified labels for matching underlying pods by the deployment|
|workloadMetaOverrides|[types.MetaBase](#metabase)|Override metadata of the created resources|
|workloadOverrides|[types.PodSpecBase](#podspecbase)|Override podSpec fields for the given deployment|
|containerOverrides|[types.ContainerBase](#containerbase)|Override container fields for the given deployment|

## Kubernetes Host Tailers

Tailing logs from the nodes like `kubelet`, `audit` logs or from the `systemd` journal.

### Systemd Tailer configuration options

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| name | string | Yes | - | Name for the tailer<br> |
| path | string | No |  /var/log/journal | Override systemd log path <br> |
| systemdFilter | string | No | - | Filter to select systemd unit example: kubelet.service<br> |
| maxEntries | int | No | - | Maximum entries to read when starting to tail logs to avoid high pressure<br> |
| disabled | bool | No | - | Disable component<br> |
| workloadMetaOverrides |[types.MetaBase](#metabase)| No | - | Override metadata of the created resources |
| workloadOverrides |[types.PodSpecBase](#podspecbase)| No | - | Override podSpec fields for the given daemonset |
| containerOverrides |[types.ContainerBase](#containerbase)| No | - | Override container fields for the given daemonset |

### Kubernetes Systemd tailer

Tail logs from the systemd journal. Define one or more systemd tailers in the `Observer`
configuration.

### Example: configuration systemd tailer

```bash
one-eye reconcile -f - <<EOF
apiVersion: one-eye.banzaicloud.io/v1alpha1
kind: Observer
metadata:
  name: observer
spec:
  controlNamespace: default
  logging:
    hostTailers:
      systemdTailers:
        - name: kubelet
          systemdFilter: kubelet.service
EOF
```

### Systemd Tailer configuration options

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| name | string | Yes | - | Name for the tailer<br> |
| path | string | No |  /var/log/journal | Override systemd log path <br> |
| systemdFilter | string | No | - | Filter to select systemd unit example: kubelet.service<br> |
| maxEntries | int | No | - | Maximum entries to read when starting to tail logs to avoid high pressure<br> |
| disabled | bool | No | - | Disable component<br> |
| workloadMetaOverrides |[types.MetaBase](#metabase)| No | - | Override metadata of the created resources |
| workloadOverrides |[types.PodSpecBase](#podspecbase)| No | - | Override podSpec fields for the given daemonset |
| containerOverrides |[types.ContainerBase](#containerbase)| No | - | Override container fields for the given daemonset |

### Kubernetes Host File tailer

Tail logs from the node's host filesystem. Define one or more file tailers in the `Observer`
configuration.

### Example: configuration host file tailer

```bash
one-eye reconcile -f - <<EOF
apiVersion: one-eye.banzaicloud.io/v1alpha1
kind: Observer
metadata:
  name: observer
spec:
  controlNamespace: default
  logging:
    hostTailers:
      fileTailers:
        - name: audit-log
          path: /var/log/audit.log
EOF
```

### File Tailer configuration options

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| name | string | Yes | - | Name for the tailer<br> |
| path | string | No | - | Path for the file on the host<br> |
| hostPath | string | No | - | Override the mount point for the path<br> |
| tag | string | No | - | Override fluent tag<br> |
| disabled | bool | No | - | Disable component<br> |
| workloadMetaOverrides |[types.MetaBase](#metabase)| No | - | Override metadata of the created resources |
| workloadOverrides |[types.PodSpecBase](#podspecbase)| No | - | Override podSpec fields for the given daemonset |
| containerOverrides |[types.ContainerBase](#containerbase)| No | - | Override container fields for the given daemonset |

### Advanced configuration overrides

### MetaBase

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| annotations | `map[string]string` | No | - |  |
| labels | `map[string]string` | No | - |  |

### PodSpecBase

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| tolerations | `[]corev1.Toleration` | No | - |  |
| nodeSelector | `map[string]string` | No | - |  |
| serviceAccountName | `string` | No | - |  |
| affinity | `*corev1.Affinity` | No | - |  |
| securityContext | `*corev1.PodSecurityContext` | No | - |  |
| volumes | `[]corev1.Volume` | No | - |  |

### ContainerBase

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| resources | `*corev1.ResourceRequirements` | No | - |  |
| image | `string` | No | - |  |
| pullPolicy | `corev1.PullPolicy` | No | - |  |
| command | `[]string` | No | - |  |
| volumeMounts | `[]corev1.VolumeMount` | No | - |  |
| securityContext | `*corev1.SecurityContext` | No | - |  |
