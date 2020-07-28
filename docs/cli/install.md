---
title: Installing One Eye CLI
shortTitle: Install
weight: 10
---

To quickly install the CLI, use the following command. To upgrade an existing installation, see [Upgrade the CLI](../upgrade/).

```bash
$ curl https://getoneeye.sh | sh
```

The [script](https://getoneeye.sh) automatically chooses the best distribution package for your platform.

Available packages:

- [Deb package](https://banzaicloud.com/downloads/one-eye/latest?format=deb) --- for latest Ubuntu LTS and Debian stable releases
- [RPM package](https://banzaicloud.com/downloads/one-eye/latest?format=rpm) --- for latest CentOS, RHEL, SLES or openSUSE releases
- binary tarballs for [Linux](https://banzaicloud.com/downloads/one-eye/latest?os=linux) and [macOS](https://banzaicloud.com/downloads/one-eye/latest?os=darwin) (x86_64).

You can also select the installation method (one of `auto`, `deb`, `rpm`, `brew`, `tar`) explicitly:

```bash
$ curl https://getoneeye.sh | sh -s -- deb
```

On macOS, you can install the CLI directly from ***Homebrew***:

```bash
$ brew install banzaicloud/tap/one-eye
```

## Next steps

* [One Eye Command Reference](../reference/)	
