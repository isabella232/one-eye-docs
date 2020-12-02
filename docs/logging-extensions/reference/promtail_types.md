---
title: Promtail
weight: 200
generated_file: true
---

### PromtailSpec
#### PromtailSpec defines the desired state of Promtail

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| namespace | string | Yes | - | The resources of Promtail will be placed into this namespace<br> |
| enableRecreateWorkloadOnImmutableFieldChange | bool | No | - | EnableRecreateWorkloadOnImmutableFieldChange enables the operator to recreate the<br>daemonset (and possibly other resource in the future) in case there is a change in an immutable field<br>that otherwise couldn't be managed with a simple update.<br> |
| workloadMetaOverrides | *types.MetaBase | No | - | Override metadata of the created resources<br> |
| workloadOverrides | *types.PodSpecBase | No | - | Override podSpec fields for the given daemonset<br> |
| containerOverrides | *types.ContainerBase | No | - | Override container fields for the given statefulset<br> |
| containerRuntime | string | No | - | Container Runtime  (docker, containerd)<br> |
| pipelineStages | []string | No | - | PipelineStages  (docker, cri)<br> |
| lokiUrl | string | No | - | Loki URL http://loki:3100/loki/api/v1/push<br> |
| security | *Security | No | - | Security defines promtail deployment security properties<br> |
| tolerations | []corev1.Toleration | No | - |  |
| nodeSelector | map[string]string | No | - |  |
| affinity | *corev1.Affinity | No | - |  |
| podPriorityClassName | string | No | - |  |
| resources | corev1.ResourceRequirements | No | - |  |
| image | ImageSpec | No | - |  |
### PromtailStatus
#### PromtailStatus defines the observed state of Promtail

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
### Promtail
#### Promtail is the Schema for the promtails API

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
|  | metav1.TypeMeta | Yes | - |  |
| metadata | metav1.ObjectMeta | No | - |  |
| spec | PromtailSpec | No | - |  |
| status | PromtailStatus | No | - |  |
### PromtailList
#### PromtailList contains a list of Promtail

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
|  | metav1.TypeMeta | Yes | - |  |
| metadata | metav1.ListMeta | No | - |  |
| items | []Promtail | Yes | - |  |
### Security
#### Security defines promtail deployment security properties

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| serviceAccount | string | No | - |  |
| roleBasedAccessControlCreate | *bool | No | - |  |
| podSecurityPolicyCreate | bool | No | - |  |
| securityContext | *corev1.SecurityContext | No | - |  |
| podSecurityContext | *corev1.PodSecurityContext | No | - |  |
### ImageSpec
#### ImageSpec struct hold information about image specification

| Variable Name | Type | Required | Default | Description |
|---|---|---|---|---|
| repository | string | No | - |  |
| tag | string | No | - |  |
| pullPolicy | string | No | - |  |
