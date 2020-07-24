---
title: Command reference
shortTitle: Reference
weight: 30
---

## List of available commands

The following commands are available in the `one-eye` command-line tool.

### Synopsis

Install and manage One Eye

```text
Usage:
  one-eye [command]

Available Commands:

  cert-manager   Manage the cert-manager chart
  help           Help about any command
  ingress        Manage ingress for one-eye
  license        Show Evaluation License
  logging        Manage the logging components
  loki           Manage the loki chart
  prometheus     Manage the prometheus-operator chart
  reconcile      Reconcile all components of an Observer
  removeall      Removes all previously installed operators
  tailer-webhook Manage the tailer-webhook
  thanos         Manage the Thanos components
```

### Options

```
      --accept-license     accept evaluation license
  -h, --help               help for one-eye
  -n, --namespace string   kubernetes namespace
      --non-interactive    non-interactive mode
  -v, --verbosity int      log level. raise to get more detailed log output (default 1)
      --version            Show version of one-eye
```

### Cleanup and Uninstall {#uninstall}

To remove the One Eye and any other components from your cluster, run the following command. It takes care of removing these components in the correct order.

```bash
$ one-eye removeall
```

To delete the One Eye operator, run:

```bash
$ helm del --purge one-eye-operator
```

### SEE ALSO

{{< toc >}}