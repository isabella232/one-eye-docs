---
title: Upgrade One Eye CLI
shortTitle: Upgrade
weight: 40
---

How you can upgrade an existing One Eye CLI installation depends on how you have originally installed it.

In general, you can run the following command to upgrade and install the appropriate package for your platform:

```bash
curl https://getoneeye.sh | sh -s -- auto
```

- **On macOS**:

    - If you have installed One Eye CLI with Homebrew:

        ```bash
        $ brew upgrade banzaicloud/tap/one-eye
        ```

- **On Linux**: Download and install the appropriate package for your distribution.

    - [Deb package](https://banzaicloud.com/downloads/one-eye/latest?format=deb) --- for latest Ubuntu LTS and Debian stable releases
    - [RPM package](https://banzaicloud.com/downloads/one-eye/latest?format=rpm) --- for latest CentOS, RHEL, SLES or openSUSE releases
