# unpackerr

Helm chart for Unpackerr, a daemon that extracts downloads for Sonarr, Radarr, and Lidarr.

## Introduction

This chart bootstraps an [Unpackerr](https://unpackerr.zip/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

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
