---
title: one-eye logging configure
generated_file: true
---
## one-eye logging configure

Configure the logging system managed by the Logging Operator

### Synopsis

Configure the logging system managed by the Logging Operator

```
one-eye logging configure [flow|clusterflow|output|clusteroutput] [flags]
```

### Options

```
  -h, --help             help for configure
      --logging string   name of the logging resource to be created (default "one-eye")
      --path string      directory to save generated resource configs (default ".")
      --secure           configure secure connection between fluentbit and fluentd (cert-manager required)
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

