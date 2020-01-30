#!/bin/bash -eux

# Script to update tekton yaml files form upstream

curl -L https://github.com/tektoncd/dashboard/releases/download/v0.4.1/dashboard_latest_release.yaml > templates/tekton-dashboard.yaml

curl -L https://github.com/tektoncd/pipeline/releases/download/v0.10.1/release.yaml | sed \
  -e '17 a\ \ labels:\n\ \ \ \ app: kubed' \
> templates/tekton-pipelines.yaml
