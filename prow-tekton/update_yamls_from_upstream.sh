#!/bin/bash -eux

TEKTON_DASHBOARD_VERSION="v0.4.1"
TEKTON_PIPELINE_VERSION="v0.10.1"

# Script to update tekton yaml files form upstream

curl -sL https://github.com/tektoncd/dashboard/releases/download/${TEKTON_DASHBOARD_VERSION}/dashboard_latest_release.yaml > templates/tekton-dashboard.yaml

curl -sL https://github.com/tektoncd/pipeline/releases/download/${TEKTON_PIPELINE_VERSION}/release.yaml | sed \
  -e '17 a\ \ labels:\n\ \ \ \ app: kubed' \
> templates/tekton-pipelines.yaml


# Script to update prow yaml files form upstream

curl -s https://raw.githubusercontent.com/kubernetes/test-infra/master/prow/cluster/starter.yaml > templates/starter.yaml-upstream

tac templates/starter.yaml-upstream | sed \
  -e 's/namespace: default/namespace: {{ $.Values.prow_namespace }}/' \
  -e 's/prowjob_namespace: default/prowjob_namespace: {{ $.Values.prowjob_namespace }}/' \
  -e 's/: test-pods/: {{ $.Values.prowjob_namespace }}/' \
  -e '/          servicePort: 8888/,/^---$/d;' \
  -e '/  plugins.yaml: ""/,/^---$/d' \
  -e '/command: \["\/bin\/date"\]/,/^---$/d' \
| tac > templates/prow.yaml
