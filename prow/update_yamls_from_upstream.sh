#!/bin/bash -eux

# Script to update prow yaml files form upstream

curl https://raw.githubusercontent.com/kubernetes/test-infra/master/prow/cluster/starter.yaml > templates/starter.yaml-upstream

tac templates/starter.yaml-upstream | sed \
  -e 's/namespace: default/namespace: {{ $.Values.namespace }}/' \
  -e 's/prowjob_namespace: default/prowjob_namespace: {{ $.Values.prowjob_namespace }}/' \
  -e 's/: test-pods/: {{ $.Values.prowjob_namespace }}/' \
  -e '/          servicePort: 8888/,/^---$/d;' \
  -e '/  plugins.yaml: ""/,/^---$/d' \
  -e '/command: \["\/bin\/date"\]/,/^---$/d' \
| tac > templates/prow.yaml
