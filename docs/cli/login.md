---
title: Log in to One Eye
shorttitle: Log in to One Eye
weight: 20
---

To access One Eye, set your KUBECONFIG file to the cluster where the One Eye control plane is running, then run the following command.

The following command installs an `nginx` ingress and the [One Eye](/products/one-eye/) UI. This ingress is exposed to localhost by default, but you can connect to it via One Eye.

```bash
$ one-eye ingress install --update
```

To access the [One Eye web interface](/docs/one-eye-docs/configuration-overview/), run the `one-eye ingress connect` command.

## Next steps

Once you have logged in, you can use other One Eye [commands](../reference/), or use One Eye in [reconciler or operator mode]({{< relref "/docs/one-eye/modes-of-operation/_index.md" >}}).
