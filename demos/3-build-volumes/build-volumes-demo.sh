#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

oc new-project build-volumes
oc create imagestream nodejs-ex

p "You can add persistent volumes for builds, to hold things like dependency caches"
p "Let's create a PVC to cache image layers for buildah"
cat 00-cache-pvc.yaml
pe "oc apply -f 00-cache-pvc.yaml"
wait
clear

p "We can create a BuildStrategy for just our namespace to experiment"
pe "grep -C 3 'volume' 01-buildah-cache-strategy.yaml"
pe "oc apply -f 01-buildah-cache-strategy.yaml"
wait
clear

p "Let's run a first build - how long does it take?"
pe "time shp build run buildah-nodejs --follow"
wait
clear

p "Let's run the build again - how long will this take?"
pe "time shp build run buildah-nodejs --follow"
p "See the difference?"
