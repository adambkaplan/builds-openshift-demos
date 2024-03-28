#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

oc new-project demo-buildpacks
oc create imagestream nodejs-ex
clear

p "New in Builds for OpenShift - Red Hat Buildpacks Dev Preview"
echo "oc apply -f https://raw.githubusercontent.com/redhat-developer/openshift-builds-catalog/main/clusterBuildStrategy/buildpacks/buildpacks.yaml"
wait
oc apply -f https://raw.githubusercontent.com/redhat-developer/openshift-builds-catalog/main/clusterBuildStrategy/buildpacks/buildpacks.yaml
pe "oc get clusterbuildstrategies"
wait
clear

p "Let's build our nodejs app with UBI buildpacks!"
cat 01-buildpacks-nodejs-build.yaml
pe "oc apply -f 01-buildpacks-nodejs-build.yaml"
pe "shp build run buildpacks-nodejs --follow"
p "This is Dev Preview with Builds 1.0 - stay tuned!"
clear

# oc delete project demo-buildpacks