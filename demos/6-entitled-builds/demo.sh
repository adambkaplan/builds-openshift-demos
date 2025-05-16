#!/usr/bin/env bash

# shellcheck source-path=lib
. ../../lib/demo-magic.sh

oc new-project buildah-entitlement
oc create imagestream buildah-bootc
oc import-image rhel-bootc --from="registry.redhat.io/rhel10/rhel-bootc:10.0-1747275807" --confirm
clear

p "Suppose our build needs to install RHEL packages:"
pe "cat build/Containerfile"
p "With Builds 1.2+, we can use the cluster's subscription to install RHEL content!"
clear

p "To access the subscription, a cluster admin first needs to share it using a SharedSecret object."
cat 00-rhel-entitlement-sharedsecret.yaml
pe "oc apply -f 00-rhel-entitlement-sharedsecret.yaml"
wait
p "The cluster admin should also create a ClusterRoleBinding to let others use the SharedSecret."
cat 01-role-use-shared-secret.yaml
pe "oc apply -f 01-role-use-shared-secret.yaml"
wait
clear

p "Next, the cluster admin needs to grant the Shared Resource CSI Driver permission to access the underlying Secret object."
cat 02-rhel-entitlement-csi-role.yaml
echo "---"
cat 02-rhel-entitlement-csi-rolebinding.yaml
pe "oc apply -f 02-rhel-entitlement-csi-role.yaml"
pe "oc apply -f 02-rhel-entitlement-csi-rolebinding.yaml"
wait
clear

p "After the CSI driver is granted the right RBAC, the service accounts that run the build need permission to use the SharedSecret."
p "This can be done by anyone with 'admin' permissions in the namespace."
cat 03-rolebinding-use-shared-secret.yaml
pe "oc apply -f 03-rolebinding-use-shared-secret.yaml"
wait
clear

p "Finally, we configure a build to mount the SharedSecret into the build, and run it!"
p "Let's use this to build a bootc image with the real-time kernel installed."
cat 04-entitled-build.yaml
pe "oc apply -f 04-entitled-build.yaml"
pe "shp build run buildah-bootc -F"
wait
p "Our build ran and successfully installed the RHEL real-time kernel!"
wait
clear

oc delete project buildah-entitlement
oc delete rolebinding share-etc-pki-entitlement -n openshift-config-managed
oc delete role share-etc-pki-entitlement -n openshift-config-managed
oc delete clusterrole use-share-etc-pki-entitlement
oc delete sharedsecret etc-pki-entitlement
