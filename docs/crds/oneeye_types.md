---
title: Observer
weight: 200
generated_file: true
---

### ObserverSpec
#### ObserverSpec defines the desired state of Observer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| thanos | Thanos | No | - | Thanos component descriptor<br> |
| logging | Logging | No | - | Logging component descriptor<br> |
| prometheus | Prometheus | No | - | Prometheus component descriptor<br> |
| certmanager | CertManager | No | - | CertManager component descriptor<br> |
| loki | Loki | No | - | Loki component descriptor<br> |
| ingress | Ingress | No | - | Ingress component descriptor<br> |
| elasticSearch | ElasticSearch | No | - | ElasticSearch component descriptor<br> |
| controlNamespace | string | Yes | - | Observer will be placed into this namespace<br> |
### ObserverStatus
#### ObserverStatus defines the observed state of Observer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| certmanager | CertManagerStatus | No | - |  |
| elasticSearch | ElasticSearchStatus | No | - |  |
| ingress | IngressStatus | No | - |  |
| logging | LoggingStatus | No | - |  |
| loki | LokiStatus | No | - |  |
| prometheus | PrometheusStatus | No | - |  |
| thanos | ThanosStatus | No | - |  |
### Observer
| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
|  | metav1.TypeMeta | Yes | - |  |
| metadata | metav1.ObjectMeta | No | - |  |
| spec | ObserverSpec | No | - |  |
| status | ObserverStatus | No | - |  |
### ObserverList
#### ObserverList contains a list of Observer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
|  | metav1.TypeMeta | Yes | - |  |
| metadata | metav1.ListMeta | No | - |  |
| items | []Observer | Yes | - |  |
