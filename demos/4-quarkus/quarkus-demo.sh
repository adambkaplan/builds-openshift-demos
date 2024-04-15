#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

oc new-project demo-builds
oc create imagestream quinoa-wind-turbine
clear

p "Let's create a build strategy for Quarkus!"
p "Start with a cache - we may need to download a lot of dependencies!"
cat 00-cache-pvc.yaml
pe "oc apply -f 00-cache-pvc.yaml"
wait
clear

p "Now we add a maven step before building the image."
p "Quarkus will create a Dockerfile for us, that will be passed to buildah."
head -n 25 01-quarkus-buildah-cache-strategy.yaml
pe "oc apply -f 01-quarkus-buildah-cache-strategy.yaml"
wait
clear

p "Let's build a real Quarkus demo app - quinoa-wind-turbine"
cat 02-quinoa-wind-turbine-build.yaml
pe "oc apply -f 02-quinoa-wind-turbine-build.yaml"
wait
clear

p "Let's run a first build - how long does it take?"
pe "time shp build run quinoa-wind-turbine --follow"
wait
clear

p "Let's run the build again - how long will this take?"
pe "time shp build run quinoa-wind-turbine --follow"
p "See the difference?"
