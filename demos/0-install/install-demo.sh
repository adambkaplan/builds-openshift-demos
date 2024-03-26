#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

clear

p "Install Builds for OpenShift with OperatorHub."

p "First, install OpenShift Pipelines."
cat 01-openshift-pipelines.yaml
pe "oc apply -f 01-openshift-pipelines.yaml"
wait
clear

p "Next, install Builds for OpenShift"
cat 02-builds-rh-openshift.yaml
pe "oc apply -f 02-builds-rh-openshift.yaml"
wait
clear

p "Finally, deploy Shipwright using its custom resource"
cat "03-shipwright-build.yaml"
pe "oc apply -f 03-shipwright-build.yaml"
wait
clear

p "Once deployed, the buildah and source-to-image (s2i) build strategies are available"
pe "oc get clusterbuildstrategies"
p "Now you are ready to build applications with Shipwright!"
