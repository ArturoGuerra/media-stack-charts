# tdarr

Helm chart for Tdarr, a distributed video transcoding and health-checking system.

## Introduction

This chart bootstraps a [Tdarr](https://tdarr.io/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

## Prerequisites

- Kubernetes 1.16+
- Helm 3.0+

## Installing the Chart

To install the chart with the release name `my-release`:

```bash
helm install my-release .
```

## Configuration

See [values.yaml](values.yaml) for configuration options.

## Persistence

The chart provides various ways to configure persistence. See the `persistence` section in `values.yaml`.

## Worker Configuration

Tdarr workers (nodes) are configured under `worker` in `values.yaml`:

- `worker.defaults` — baseline settings (image, resources, env, transcode scratch volume, nodeSelector/tolerations/affinity, runtimeClassName, etc.) applied to every worker.
- `worker.instances` — a map of worker-name -> overrides, deep-merged onto `worker.defaults`. Add an entry to run an additional, differently configured worker (e.g. a GPU-enabled worker) alongside the default one. Each instance is enabled by default; set `enabled: false` to disable a specific worker without removing its configuration.

Each instance renders its own Deployment and ConfigMap named `<release>-tdarr-<instance-key>`. The default instance ships under the key `node`.

Note: `mustMergeOverwrite` deep-merges map fields (e.g. `env`, `nodeSelector`) but replaces list fields (`tolerations`, `extraVolumes`, `extraVolumeMounts`) wholesale — a worker overriding one of these must repeat the full list, not just append to it.

Example: adding a second, GPU-enabled worker:

```yaml
worker:
  instances:
    gpu:
      runtimeClassName: nvidia
      resources:
        limits:
          nvidia.com/gpu: "1"
      nodeSelector:
        gpu: "true"
```
