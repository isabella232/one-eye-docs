---
title: Overview
weight: -10
---

{{% include-headless "doc/one-eye-intro.md" %}}

Banzai Cloud One Eye provides scalable, unified, and automated log and metric collection for your entire Kubernetes infrastructure, including cluster nodes, pods, applications, and services. It works on a variety of Kubernetes infrastructures, including on-premises solutions and cloud providers like AWS, Azure, Google Cloud, or Alibaba.

What's more, Banzai Cloud One Eye natively supports multi-cluster and hybrid-cluster scenarios, and gives your teams a single location to query and analyze all the collected data, no matter if they need it for devops, maintenance, or compliance reasons.

Built on Prometheus, Thanos, Grafana, Loki, Fluentd, and Fluent Bit. Managed by the Banzai Cloud Logging operator and Banzai Cloud Thanos operator.

## Feature highlights

- Manage your logging infrastructure through a web UI, CLI, or declaratively
- Visualize your logging infrastructure
- Drill-down through alerts, services, workloads, pod logs, and other sources
- Collect logs and metrics from pods and host files
- Collect Kubernetes events
- Enable encrypted communication between the components

## Architecture

One Eye incorporates a number of carefully selected and well-known components, and manages their configuration to integrate them into a coherent system that allows you to setup an enterprise-grade logging infrastructure within minutes.

<!-- FIXME Architecture abra -->

## Manage your logging infrastructure

Choose the method to manage your logging infrastructure that best fits your projects maturity, from Day 0 to Day 2. One Eye allows you to manage your cloud logging infrastructure using:

- a command-line tool,
- a web interface, or
- declaratively as an operator.

![Modes of operation](/docs/one-eye/headless/day0-2.gif)

## Visualize your logging infrastructure

One Eye visualizes your logging infrastructure: your logging sources, flows, and outputs. In addition, you can access all the relevant metrics, logs, and other information with a few clicks.

![One Eye Dashboard](/docs/one-eye/configure-logging-infrastructure/configuration-overview/overview-nocallouts.png)

## Drill-down to find problems fast

Using the One Eye web UI, you can drill-down from the service, workload, or alert level, and trace back an issue by navigating deeper in the stack, and see the status, events, and most important metrics of your **Kubernetes controllers, pods, and nodes**.

## Collect logs from a wide range of sources

One Eye allows you to collect a wide range of logs and metrics to give you the best possible overview of your infrastructure.
In addition to application logs, it can collect Kubernetes events, host and pod logs, including the Fluentd pod logs, as well as logs from custom host files, like audit logs, systemd journals, and kubelet logs.

## Enable encrypted communication

One Eye provides a simple way to enable SSL encryption between the components of your logging infrastructure, and automates its management using cert-manager: it creates the custom resources required for TLS certificates, and renews the configuration of Fluentd and Fluent Bit accordingly.

## Next steps

- [Jump to the installation section](../cli/install/)
- [View One Eye related blogposts](/tags/observability/)
- [Schedule a demo]({{< relref "/contact/_index.md" >}})
