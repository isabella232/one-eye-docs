---
title: Troubleshooting One Eye
shorttitle: Troubleshooting One Eye
weight: 1000
---

## Check Fluentd logs

One Eye doesn't send Fluentd logs to the standard output, because a bad configuration can cause a self-perpetuating process, generating logs exponentially. To avoid this, Fluentd logs are stored inside the container under the `/fluentd/log/out` path.

To debug the Logging operator, always check the Fluentd logs first. In One Eye, you can access and search these logs from the web UI:

1. Navigate to **![Main Menu](/docs/one-eye/headless/icon-main-menu.png) > LOGGING OVERVIEW > ![Open Fluentd pod logs](/docs/one-eye/headless/icon-fluentd-logs.png)**. A panel opens showing the Fluentd pod logs.

    ![Fluentd Logs](fluentd-pod-logs-1.png)

1. If you are running multiple replicas, select which Fluentd pod you want to query.
1. Browse the logs, or use the **Search** field.

    ![Fluentd Logs](fluentd-pod-logs-2.png)

## Explain Observer configuration {#explain}

To display the documentation of the Observer custom resource, you can use the **one-eye explain** command, which is similar to *kubectl explain*. For example:

```bash
$ one-eye observer explain spec
KIND:     Observer
VERSION:  one-eye.banzaicloud.io/v1alpha1

RESOURCE: spec <Object>

DESCRIPTION:
     ObserverSpec defines the desired state of Observer

FIELDS:
   certmanager <Object>
     CertManager component descriptor

   clusterName <string>
     Custom name for cluster
...
```