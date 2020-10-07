---
title: Logging flows and outputs
weight: 200
---

You can configure the logging infrastructure from the command line by configuring the [Logging operator](/docs/one-eye/logging-operator/) and the [Logging Extensions operator](/docs/one-eye/logging-extensions/). Currently the One Eye web interface offers limited support to configure logging flows and logging outputs.

> To modify the configuration of an existing object, click on the object on the **MENU > LOGGING OVERVIEW**, then select **Configuration**.

To create a new logging flow or a logging output on the UI, complete the following steps.

1. Navigate to **MENU > LOGGING OVERVIEW**, then click ![Create new icon](/docs/one-eye/headless/icon-create-new.png).
1. Select the type of resource you want to create (flow or output).
1. Select the namespace where you want to apply the new resource.
    ![Create logging flows and outputs](/docs/one-eye/configure-logging-infrastructure/configuration-overview/create-flow.png)
1. Import the YAML configuration of the resource, or create a new one in the browser.

    - For details on configuring different output types, see the {{% xref "/docs/one-eye/logging-operator/quickstarts/_index.md" %}}.
    - For details on the possible configuration values, see [Logging flows]({{< relref "/docs/one-eye/logging-operator/crds/_index.md#flows-clusterflows" >}}) and [Logging outputs]({{< relref "/docs/one-eye/logging-operator/crds/_index.md#outputs-clusteroutputs" >}}).

1. Click **CREATE**. One Eye validates the configuration and creates the new resource.
