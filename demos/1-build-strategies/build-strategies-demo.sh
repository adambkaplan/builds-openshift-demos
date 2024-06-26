#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

oc new-project demo-builds

clear

p "Builds for OpenShift lets you choose the right tool to build your application."
p "First, we define a \`Build\` for our application"
cat 01-s2i-nodejs-build.yaml
pe "oc apply -f 01-s2i-nodejs-build.yaml"
p "Let's also create an imagestream for our output image"
pe "oc create imagestream nodejs-ex"
wait
clear

p "We use the shp command line to start a build"
pe "shp build run s2i-nodejs --follow"
wait
clear

p "We don't have to choose - with a Dockerfile, we can build with buildah too."
cat 02-buildah-nodejs-build.yaml

pe "oc apply -f 02-buildah-nodejs-build.yaml"
wait
clear
pe "shp build run buildah-nodejs --follow"

p "You can use other strategies to build applications, or even create your own!"
p "Check out shipwright.io for additional info!"
wait
clear
