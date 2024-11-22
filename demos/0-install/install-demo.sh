#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

oc apply -f 00-namespace.yaml

clear

p "Install Builds for OpenShift with OperatorHub."

p "First, install OpenShift Pipelines."
cat 01-openshift-pipelines.yaml
pe "oc apply -f 01-openshift-pipelines.yaml"
pe "oc wait --for condition=available deployment/openshift-pipelines-operator -n openshift-operators --timeout=5m"
wait
clear

p "Next, install Builds for OpenShift"
cat 02-builds-rh-openshift.yaml
pe "oc apply -f 02-builds-rh-openshift.yaml"
pe "oc wait --for condition=available deployment/openshift-builds-operator -n openshift-builds --timeout=5m"
wait
clear

p "Once deployed, the buildah and source-to-image (s2i) build strategies are available"
pe "oc get clusterbuildstrategies"
p "Now you are ready to build with OpenShift!"
