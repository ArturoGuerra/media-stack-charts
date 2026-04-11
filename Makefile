SHELL := /bin/bash

CHARTS := bazarr checkrr cleanuparr doplarr jellyfin lidarr maintainerr membarr nzbget plexmediaserver prowlarr qbittorrent qui radarr recyclarr requestrr scraparr sonarr tautulli tdarr unpackerr wizarr
DIST_DIR ?= dist
REPO_URL ?=
OCI_REGISTRY ?=

.PHONY: verify lint template deps package repo-index oci-push clean

verify: lint template package

lint:
	@for c in $(CHARTS); do \
		echo "==> helm lint $$c"; \
		helm lint $$c; \
	done

template:
	@for c in $(CHARTS); do \
		echo "==> helm template $$c"; \
		helm template test $$c >/dev/null; \
	done

deps:
	@for c in $(CHARTS); do \
		echo "==> helm dependency build $$c"; \
		helm dependency build $$c >/dev/null; \
	done

package: deps
	@mkdir -p $(DIST_DIR)
	@for c in $(CHARTS); do \
		echo "==> helm package $$c"; \
		helm package $$c -d $(DIST_DIR) >/dev/null; \
	done

repo-index: package
	@if [[ -z "$(REPO_URL)" ]]; then echo "REPO_URL is required"; exit 1; fi
	helm repo index $(DIST_DIR) --url $(REPO_URL)

oci-push: package
	@if [[ -z "$(OCI_REGISTRY)" ]]; then echo "OCI_REGISTRY is required (e.g. ghcr.io/org/charts)"; exit 1; fi
	@for pkg in $(DIST_DIR)/*.tgz; do \
		echo "==> helm push $$pkg oci://$(OCI_REGISTRY)"; \
		helm push $$pkg oci://$(OCI_REGISTRY); \
	done

clean:
	rm -rf $(DIST_DIR)
