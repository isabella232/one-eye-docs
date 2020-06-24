---
title: one-eye ingress install
generated_file: true
---
## one-eye ingress install

Install ingress for one-eye

### Synopsis

Install ingress for one-eye

```
one-eye ingress install [flags]
```

### Options

```
      --disable-ui              disable one-eye web interface
  -h, --help                    help for install
      --host string             ingress domain name (default "localhost")
      --loki-url string         override loki URL
      --prometheus-url string   override prometheus URL
      --pull                    always pull the UI image
      --ui-image string         UI image
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

* [one-eye ingress](/docs/one-eye/cli/reference/one-eye_ingress/)	 - Manage ingress for one-eye

