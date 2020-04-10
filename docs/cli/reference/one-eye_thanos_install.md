---
title: one-eye thanos install
generated_file: true
---
## one-eye thanos install

Install a Thanos stack attached to an existing in-cluster Prometheus

### Synopsis

Install a Thanos stack attached to an existing in-cluster Prometheus

```
one-eye thanos install [flags]
```

### Options

```
  -h, --help                    help for install
      --operator-image string   override the operator image being used
      --prometheus              install prometheus and grafana using prometheus operator
      --secret string           name/key of the object store configuration secret item
      --update                  update an existing thanos installation
```

### Options inherited from parent commands

```
      --accept-license     accept evaluation license
  -n, --namespace string   kubernetes namespace
      --non-interactive    non-interactive mode
  -v, --verbosity int      log level. raise to get more detailed log output (default 1)
```

### SEE ALSO

* [one-eye thanos](/docs/one-eye/cli/reference/one-eye_thanos/)	 - Manage the Thanos components

