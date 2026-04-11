# tautulli

Helm chart for Tautulli, a monitoring and tracking tool for Plex Media Server.

## Introduction

This chart bootstraps a [Tautulli](https://tautulli.com/) deployment on a [Kubernetes](http://kubernetes.io) cluster using the [Helm](https://helm.sh) package manager.

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
