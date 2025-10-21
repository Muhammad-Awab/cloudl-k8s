This folder contains a Helm chart (`helm/cloudl`) and a `helmfile.yaml` that defines three environments: dev, staging, prod.

Usage examples:

# Lint / template with environment
helmfile -e dev template

# Apply (deploy) to the environment
helmfile -e prod apply

The chart values for each environment live in:
- helm/cloudl/values-dev.yaml
- helm/cloudl/values-staging.yaml
- helm/cloudl/values-prod.yaml

Edit those values files to change image tags, namespaces, and port/nodePort settings.
