---
title: Modes of operation
weight: 450
---

{{< contents >}}

To support the different use-cases from Day 0 to Day 2 operations, One Eye has different modes of operation. The same binary can act as:

- a CLI tool for [imperative use](#imperative),
- a [local reconciler](#reconcile), and
- a [Kubernetes operator](#operator).

## Imperative mode {#imperative}

The main purpose of the imperative mode is to install One Eye, get you started, and help you experiment with the various components. You can access only a small subset of the available configuration options and features (mostly just the default settings and some of the most important configuration flags) to avoid getting overloaded with command line flags.

Most notably, you can `install` and `delete` One Eye from the command line. Internally, the install and delete commands change the component-specific parts of the main configuration, then apply or trigger the reconciliation of the affected components.

 > Note: The CLI will try to detect if an operator is already running in the cluster. If it does, it just updates Observer configuration and waits for changes to take effect instead of applying by itself. 

![Imperative mode - Declarative installer day0](/img/blog/declarative-installer/day0.png)

Other commands do not necessarily change the main configuration, nor trigger reconciliation of any component. Such commands create dynamic resources which are out of scope for the reconcilers, but are convenient for getting started without having to leave the CLI.

Once you are finished experimenting with One Eye, the recommended way forward is to start using the reconcile command, and apply all configuration through the custom resource directly. This is analogous to how you use `kubectl create` and then switch to using `kubectl apply` when you already have a full configuration and just want to apply changes incrementally. If you are an experienced Kubernetes user, you probably skip the imperative mode and start using the reconcile command from the beginning.

The drawback of the imperative mode is that there is no overall state of components, so it can't tell what has already been installed.

### Using the imperative mode

To use One Eye in imperative mode, [install the one-eye command-line tool](../cli/install/), then use its commands to install One Eye and perform other actions. For a list of available commands, see the [CLI reference](../cli/reference/).

> Note: You can also monitor and configure many aspects of your logging infrastructure using the One Eye web interface. To access the web interface run the `one-eye ingress install --update; one-eye ingress connect` command (if your [KUBECONFIG file is set properly](../cli/login/)).

### Install/Uninstall components

The following components can be installed/uninstalled individually. The `one-eye observer removeall` command uninstalls them all. For details on installing and uninstalling the One Eye operator, see [Operator mode](#operator).

- [cert-manager]({{< relref "/docs/one-eye/cli/reference/one-eye_cert-manager.md" >}}): `one-eye cert-manager [install|uninstall]`
- [ingress (backend and UI)]({{< relref "/docs/one-eye/cli/reference/one-eye_ingress.md" >}}): `one-eye ingress [install|uninstall]`
- [logging]({{< relref "/docs/one-eye/cli/reference/one-eye_logging.md" >}}): `one-eye logging [install|uninstall]`
- [loki]({{< relref "/docs/one-eye/cli/reference/one-eye_loki.md" >}}): `one-eye loki [install|uninstall]`
- [prometheus]({{< relref "/docs/one-eye/cli/reference/one-eye_prometheus.md" >}}): `one-eye prometheus [install|uninstall]`
- [tailer-webhook]({{< relref "/docs/one-eye/cli/reference/one-eye_tailer-webhook.md" >}}): `one-eye tailer-webhook [install|uninstall]`
- [thanos]({{< relref "/docs/one-eye/cli/reference/one-eye_thanos.md" >}}): `one-eye thanos [install|uninstall]`

## Reconciler mode {#reconcile}

Reconciler mode is a declarative CLI mode. The `reconcile` command is a one-shot version of an operator's reconcile flow. It executes the component reconcilers in order, and can decide whether they require another reconciliation round, or are already finished. Reconciling can apply new configuration, and remove disabled components from the system.

 > Note: The CLI will try to detect if an operator is already running in the cluster. If it does, it just updates Observer configuration and waits for changes to take effect instead of applying by itself. 

![Reconciler mode - Declarative installer day1](/img/blog/declarative-installer/day1.png)

A component can be anything that receives the whole configuration, understands its own part from it to configure itself, and is able to delete its managed resources when disabled or removed. One Eye uses two different implementations:

- The native reconciler triggers a “resource builder” to create Kubernetes resources along with their desired state (present or absent) based on the configuration of the component. Such resource builders create CRDs, RBAC, and a Deployment resource to be able to run an operator.

- The other implementation is the Helm reconciler that basically acts as a Helm operator. It installs and upgrades an embedded chart if it has changed, or uninstalls it if it has been removed from the main configuration.

Compared to `kubectl apply`, these solutions add ordering, and allow executing custom logic if required. Also, they remove resources that are not present in the config anymore. The CLI in this case executes the control logic as well.

Compared to terraform, the dependencies are managed in a predefined execution order and have static binding using deterministic names. Lower performance, but easier to follow. Remote state is the CR saved to the API server.

### Using the reconciler mode

To use One Eye in reconciler mode, complete the following steps. In this scenario, the manifest is read from a file, allowing you to declaratively provide custom configuration for the various components.

1. [Login to your One Eye installation](../cli/login/).
1. Prepare the configuration settings you want to apply in a YAML file, and run the following command. For details on the configuration settings, see the [Observer Custom Resource](#cr).

    ```bash
    one-eye observer reconcile --from-file <path-to-file>
    ```

1. The settings applied to the components are the result of merging the `default settings` + `valuesOverride` + `managed settings`. You cannot change the managed settings to avoid misconfiguration and possible malfunction.

## Operator mode {#operator}

The operator mode follows the familiar [operator pattern](https://kubernetes.io/docs/concepts/extend-kubernetes/operator/). In operator mode, One Eye watches events on the [Observer Custom Resource](#cr), and triggers a reconciliation for all components in order, the same way you can trigger the reconcile command locally.

> Note: Unlike in the [declarative CLI mode](#reconcile), in operator mode the One Eye operator is running inside Kubernetes, and not on a client machine. This naturally means that this mode is exclusive with the install, delete, and reconcile commands.

![Operator mode - Declarative installer day2](/img/blog/declarative-installer/day2.png)

Using the operator mode is the recommended way to integrate the One Eye installer into a Kubernetes-native continuous delivery solution, for example, ArgoCD, where the integration boils down to applying YAML files to get the installer deployed as an operator.

Existing configurations managed using the `reconcile` command work out-of-the box after switching to the operator mode.

### Using the operator mode

To use One Eye in operator mode, complete the following steps. In this scenario, the reconcile flow runs on the Kubernetes cluster as an operator that watches the `ControlPlane` custom resources. Any changes made to the watched custom resource triggers the [reconcile flow](#reconcile).

1. [Login to your One Eye installation](../cli/login/).
1. Run the following commands to install the One Eye operator.

    ```bash
    helm repo add banzaicloud-stable https://kubernetes-charts.banzaicloud.com/
    helm install --name=one-eye --namespace=one-eye-system banzaicloud-stable/one-eye
    ```

### Uninstall the operator {#operator-uninstall}

If have used the One Eye operator on a cluster and want to delete One Eye and the operator, run the following commands.

```bash
one-eye observer removeall
helm del one-eye
```

## The Observer Custom Resource {#cr}

One Eye installs the Observer Custom Resource with the following default values.

```yaml
apiVersion: one-eye.banzaicloud.io/v1alpha1
kind: Observer
metadata:
  name: one-eye
spec:
  controlNamespace: default
  ingress: {}
  logging:
    extensions: {}
    operator: {}
  prometheus:
    prometheusOperatorChart: {}
  thanos: {}
```
