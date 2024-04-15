# Builds for Red Hat OpenShift Demos

Builds for Red Hat OpenShift demos, based on Shipwright and other upstream projects.

_Disclaimer_: This is my personal collection of Builds for OpenShift demos.
More "official" information can be found in the following locations:

- Shipwright upstream docs: [shipwright.io/docs](https://shipwright.io/docs/)
- Red Hat customers: Builds for Red Hat OpenShift [product documentation](https://docs.openshift.com/builds/latest/about/overview-openshift-builds.html)

## Prerequisites

* You have access to an OpenShift cluster.
* Your user is allowed to install and manage operators.
* Demo scripts assume you are running on Linux with the following installed:
  * [pv](https://www.ivarch.com/programs/pv.shtml) package. On Fedora, run `dnf install pv`.
  * The `oc` command line. Download the latest release ("openshift-client") [here](https://mirror.openshift.com/pub/openshift-v4/clients/ocp/latest/)
  * The `shp` command line. Download the latest release [here](https://developers.redhat.com/content-gateway/rest/browse/pub/openshift-v4/clients/openshift-builds/latest/).


## Running the Demos

0. Ensure you are logged into the cluster above
1. Clone this repository
2. For the desired demo, do the following:
   1. `cd` to the demo directory.
   2. Run the respective demo script. Example for `1-build-strategies`:
      
      ```sh
      $ cd demos/1-build-strategies
      [demos/1-build-strategies]$ ./build-strategies-demo.sh
      ...
      ```
    
    3. _Note: If OpenShift Pipelines and/or Builds for OpenShift are not installed on your cluster,
       run the "0-install" demo first!_


## Table of Contents

0. Installing: [demos/0-install](demos/0-install/install-demo.sh). If your cluster does not have
   Builds for OpenShift installed, run this demo script first.
1. Build Strategies: [demos/1-build-strategies](demos/1-build-strategies/build-strategies-demo.sh).
   This demos how to build with `source-to-image` and `buildah` build strategies.
2. Cloud Native Buildpacks - coming soon!
3. Build Volumes: [demos/3-build-volumes](demos/3-build-volumes/build-volumes-demo.sh). This demos
   how to create a custom [BuildStrategy](https://shipwright.io/docs/build/buildstrategies/#overview)
   and add a [persistent volume](https://shipwright.io/docs/build/build/#defining-volumes) for
   caching.
4. Quarkus: [demos/4-quarkus](demos/4-quarkus/quarkus-demo.sh). An example of using
   [Quarkus](https://quarkus.io) to build a Java + NodeJS application with Shipwright, with a
   persistent cache to improve performance.
