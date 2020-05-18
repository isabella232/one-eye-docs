---
title: Observer
weight: 200
---

### ObserverSpec
#### ObserverSpec defines the desired state of Observer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| thanos | Thanos | No | - | Thanos component descriptor<br> |
| logging | Logging | No | - | Logging component descriptor<br> |
| prometheus | Prometheus | No | - | Prometheus component descriptor<br> |
| certmanager | CertManager | No | - | CertManager component descriptor<br> |
| ingress | Ingress | No | - | Ingress component descriptor<br> |
| controlNamespace | string | Yes | - | Observer will be placed into this namespace<br> |
### ObserverStatus
#### ObserverStatus defines the observed state of Observer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| ready | bool | No | - | Ready status flag<br> |
| summary | string | No | - | An human-readable summary of Observer's status<br> |
### Observer
#### Observer is the Schema for the observers API

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
