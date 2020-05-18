---
title: Components
weight: 200
---

### Thanos
#### Thanos component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| operator | *thanosOperator.ComponentConfig | No | - | Operator config descriptor<br> |
### Logging
#### Logging component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| operator | *loggingOperator.ComponentConfig | No | - | Operator config descriptor<br> |
| extensions | *loggingExtensions.ComponentConfig | No | - | Extensions config descriptor<br> |
### Prometheus
#### Prometheus component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| prometheusOperatorChart | *PrometheusOperatorChart | No | - | Descriptor for Helm Chart installer of Cert-Manager<br> |
### PrometheusOperatorChart
#### Descriptor for Helm Chart installer of Cert-Manager

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| disabled | bool | No | - | Disabled status<br> |
| values | string | No | - | Helm Chart values<br> |
| objectStoreConfig | *secret.Secret | No | - | Configuration for object store<br> |
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
### Ingress
#### Ingress component

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
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
