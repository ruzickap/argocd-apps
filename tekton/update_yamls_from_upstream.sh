#!/bin/bash -eux

TEKTON_DASHBOARD_VERSION="v0.4.1"
TEKTON_PIPELINE_VERSION="v0.10.1"

# Script to update tekton yaml files form upstream

curl -L https://github.com/tektoncd/dashboard/releases/download/${TEKTON_DASHBOARD_VERSION}/dashboard_latest_release.yaml > templates/tekton-dashboard.yaml

curl -L https://github.com/tektoncd/pipeline/releases/download/${TEKTON_PIPELINE_VERSION}/release.yaml | sed \
  -e '17 a\ \ labels:\n\ \ \ \ app: kubed' \
> templates/tekton-pipelines.yaml
