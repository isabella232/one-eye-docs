---
title: Logging extensions
weight: 500
---

Logging extensions are part of the Banzai Cloud One Eye observability system, and are also a standalone operator. Logging extensions were specifically developed to solve the problems of enterprises:

- Collecting Kubernetes events to provide insight into what is happening
inside a cluster, such as decisions made by the scheduler, or
why some pods were evicted from the node.
- Collect logs from the nodes like `kubelet` logs.
- Collect logs from files on the nodes, for example, `audit` logs, or the `systemd` journal.

You can configure the extensions in the One Eye custom resource configuration. It's also a standalone Kubernetes operator.

> Follow [this guide](/docs/one-eye/cli/install/) to install the One Eye command line tool.

{{< toc >}}
