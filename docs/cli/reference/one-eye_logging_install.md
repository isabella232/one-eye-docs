---
title: one-eye logging install
generated_file: true
---
## one-eye logging install

Install the Logging Operator

### Synopsis

Install the Logging Operator

```
one-eye logging install [flags]
```

### Options

```
  -h, --help                    help for install
      --operator-image string   override operator image (default "banzaicloud/logging-operator:3.1.0-rc1")
      --prometheus              install prometheus and grafana using prometheus operator
      --update                  update observer configuration
```

### Options inherited from parent commands

```
      --accept-license     accept evaluation license
  -n, --namespace string   kubernetes namespace
      --non-interactive    non-interactive mode
  -v, --verbosity int      log level. raise to get more detailed log output (default 1)
```

### SEE ALSO

* [one-eye logging](/docs/one-eye/cli/reference/one-eye_logging/)	 - Manage the logging components

