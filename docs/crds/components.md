---
title: Components
weight: 200
generated_file: true
---

### Thanos
#### Thanos component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| operator | *thanosOperator.ComponentConfig | No | - | Operator config descriptor<br> |
### ThanosStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| image | string | No | - |  |
### Logging
#### Logging component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| operator | *loggingOperator.ComponentConfig | No | - | Operator config descriptor<br> |
| extensions | *loggingExtensions.ComponentConfig | No | - | Extensions config descriptor<br> |
| tls | bool | No | - | TLS flag<br> |
### LoggingStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| image | string | No | - |  |
| extensions | LoggingExtensionsStatus | No | - |  |
### LoggingExtensionsStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| image | string | No | - |  |
### Prometheus
#### Prometheus component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| prometheusOperatorChart | *PrometheusOperatorChart | No | - | Descriptor for Helm Chart installer of Prometheus<br> |
### PrometheusOperatorChart
#### Descriptor for Helm Chart installer of Prometheus

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| disabled | bool | No | - | Disabled status<br> |
| values | string | No | - | Helm Chart values<br> |
| objectStoreConfig | *secret.Secret | No | - | Configuration for object store<br> |
### PrometheusStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| image | string | No | - |  |
### CertManager
#### Cert-Manager component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| certManagerOperatorChart | *CertManagerOperatorChart | No | - | Descriptor for Helm Chart installer of Cert-Manager<br> |
### CertManagerOperatorChart
#### Descriptor for Helm Chart installer of Cert-Manager

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| disabled | bool | No | - | Disabled status<br> |
| values | string | No | - | Helm Chart values<br> |
### CertManagerStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| image | string | No | - |  |
### Loki
#### Loki component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| lokiOperatorChart | *LokiOperatorChart | No | - | Descriptor for Helm Chart installer of Loki<br> |
### LokiOperatorChart
#### Descriptor for Helm Chart installer of Loki

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| disabled | bool | No | - | Disabled status<br> |
| values | string | No | - | Helm Chart values<br> |
### LokiStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| image | string | No | - |  |
### ElasticSearch
#### ElasticSearch component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| elasticSearchOperator | *ElasticSearchOperator | No | - | Descriptor for ElasticSearch<br> |
### ElasticSearchOperator
#### Descriptor for ElasticSearch

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| disabled | bool | No | - | Disabled status<br> |
### ElasticSearchStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| image | string | No | - |  |
### Ingress
#### Ingress component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| annotations | map[string]string | No | - | Annotations<br> |
| disabled | bool | No | - | Disabled status<br> |
| ui | *oneEyeUI.ComponentConfig | No | - | One-eye UI sub-component<br> |
| ingressSpec | *v1beta1.IngressSpec | No | - | Ingress specification<br> |
| nginxIngressChart | *NginxIngressChart | No | - | Descriptor for Helm Chart installer of nginx<br> |
### NginxIngressChart
#### Descriptor for Helm Chart installer of nginx

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| disabled | bool | No | - | Disabled status<br> |
| values | string | No | - | Helm Chart values<br> |
### IngressStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| nginx | NginxIngressStatus | No | - |  |
| ui | UIStatus | No | - |  |
### NginxIngressStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| controllerImage | string | No | - |  |
### UIStatus
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| image | string | No | - |  |
