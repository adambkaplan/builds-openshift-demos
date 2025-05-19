#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

oc new-project ubi-buildpacks
oc apply -f 00-buildpacks-build-strategy.yaml
oc apply -f 01-pipeline-privileged-scc-rolebinding.yaml
oc create secret generic dockerhub \
    --from-file=auth.json \
    --type=kubernetes.io/podmanconfigjson
oc secrets link pipeline dockerhub --for=pull
oc secrets link builder dockerhub --for=pull
oc secrets link default dockerhub --for=pull
oc create imagestream quarkus-hello
oc apply -f 02-build.yaml
oc apply -f 03-deployment.yaml
oc apply -f 04-service.yaml
oc apply -f 05-route.yaml
clear

p "Coming Soon to Builds for OpenShift - Cloud Native Buildpacks!"
pe "oc get clusterbuildstrategies"
clear

p "Let's build a Quarkus application using UBI Buildpacks!"
cat 02-build.yaml
wait
clear

pe "shp build run quarkus-hello -F"
wait
clear

# oc delete project ubi-buildpacks
# oc delete clusterbuildstrategy buildpacks
