---
title: EventTailer
weight: 200
generated_file: true
---

### EventTailerSpec
#### EventTailerSpec defines the desired state of EventTailer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| controlNamespace | string | Yes | - | The resources of EventTailer will be placed into this namespace<br> |
| positionVolume | volume.KubernetesVolume | No | - | Volume definition for tracking fluentbit file positions (optional)<br> |
| workloadMetaOverrides | *types.MetaBase | No | - | Override metadata of the created resources<br> |
| workloadOverrides | *types.PodSpecBase | No | - | Override podSpec fields for the given statefulset<br> |
| containerOverrides | *types.ContainerBase | No | - | Override container fields for the given statefulset<br> |
### EventTailerStatus
#### EventTailerStatus defines the observed state of EventTailer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
### EventTailer
#### EventTailer is the Schema for the eventtailers API

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
|  | metav1.TypeMeta | Yes | - |  |
| metadata | metav1.ObjectMeta | No | - |  |
| spec | EventTailerSpec | No | - |  |
| status | EventTailerStatus | No | - |  |
### EventTailerList
#### EventTailerList contains a list of EventTailer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
|  | metav1.TypeMeta | Yes | - |  |
| metadata | metav1.ListMeta | No | - |  |
| items | []EventTailer | Yes | - |  |
