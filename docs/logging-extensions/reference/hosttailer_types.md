---
title: HostTailer
weight: 200
generated_file: true
---

### HostTailerSpec
#### HostTailerSpec defines the desired state of HostTailer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| fileTailers | []FileTailer | No | - | List of file tailers<br> |
| systemdTailers | []SystemdTailer | No | - | List of systemd tailers<br> |
| enableRecreateWorkloadOnImmutableFieldChange | bool | No | - | EnableRecreateWorkloadOnImmutableFieldChange enables the operator to recreate the<br>daemonset (and possibly other resource in the future) in case there is a change in an immutable field<br>that otherwise couldn't be managed with a simple update.<br> |
| workloadMetaOverrides | *types.MetaBase | No | - | Override metadata of the created resources<br> |
| workloadOverrides | *types.PodSpecBase | No | - | Override podSpec fields for the given daemonset<br> |
### HostTailerStatus
#### HostTailerStatus defines the observed state of HostTailer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
### HostTailer
#### HostTailer is the Schema for the hosttailers API

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
|  | metav1.TypeMeta | Yes | - |  |
| metadata | metav1.ObjectMeta | No | - |  |
| spec | HostTailerSpec | No | - |  |
| status | HostTailerStatus | No | - |  |
### HostTailerList
#### HostTailerList contains a list of HostTailer

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
|  | metav1.TypeMeta | Yes | - |  |
| metadata | metav1.ListMeta | No | - |  |
| items | []HostTailer | Yes | - |  |
### FileTailer
#### FileTailer configuration options

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| name | string | Yes | - | Name for the tailer<br> |
| path | string | No | - | Path to the loggable file<br> |
| disabled | bool | No | - | Disable tailing the file<br> |
| containerOverrides | *types.ContainerBase | No | - | Override container fields for the given tailer<br> |
### SystemdTailer
#### SystemdTailer configuration options

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| name | string | Yes | - | Name for the tailer<br> |
| path | string | No | - | Override systemd log path<br> |
| disabled | bool | No | - | Disable component<br> |
| systemdFilter | string | No | - | Filter to select systemd unit example: kubelet.service<br> |
| maxEntries | int | No | - | Maximum entries to read when starting to tail logs to avoid high pressure<br> |
| containerOverrides | *types.ContainerBase | No | - | Override container fields for the given tailer<br> |
