#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

oc new-project build-strategies

clear

p "Builds for OpenShift lets you choose the right tool to build your application."
p "First, we define a \`Build\` for our application"
cat 01-s2i-nodejs-build.yaml
pe "oc apply -f 01-s2i-nodejs-build.yaml"
p "Let's also create an imagestream for our output image"
pe "oc create imagestream s2i-nodejs-build"
wait
clear

p "We use the shp command line to start a build"
pe "shp build run s2i-nodejs-build --follow"
wait
clear

# p "We don't have to choose - with a Dockerfile, we can build with buildah too."
# cat 02-sample-buildah-nodejs-build.yaml

# pe "oc apply -f 02-sample-buildah-nodejs-build.yaml"
# wait
# clear
# pe "shp build run sample-buildah-nodejs --follow"

p "Check out shipwright.io for additional info!"
wait
clear

oc delete project build-strategies
