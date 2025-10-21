This folder contains Kustomize base and overlays for different environments.

Usage:

Build an overlay to stdout:

  kubectl kustomize overlays/dev
  kubectl kustomize overlays/staging
  kubectl kustomize overlays/prod

Apply an overlay directly to your cluster:

  kubectl apply -k overlays/dev

Changing image tags:

Each overlay contains `patch-server-image.yaml` and `patch-client-image.yaml`. Edit those files to set the desired image tags for each environment.

Notes:
- Resources are defined under `base/resources/` and the base `kustomization.yaml` references them.
- Overlays set the `namespace` and patch images.
