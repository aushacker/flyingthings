#!/bin/bash
#
# Install operators for:
# 1. OpenShift Pipelines
# 2. Node Feature Discovery
# 
prereqs="../prereqs"
timeout=60

# Install the operators
oc apply -k "${prereqs}/pipelines/"
oc apply -k "${prereqs}/nfd/"

echo ""
echo "Waiting for operators to install"
echo ""
sleep ${timeout}

# Wait for Node Feature Discovery to install,
# should probably have a timeout...
while true
do
  oc get deployment/nfd-controller-manager -n openshift-nfd
  if [ $? -eq 0 ]; then break; fi
done

# Once the controller becomes available the custom resource can be applied
oc wait -n openshift-nfd --for=condition=Available deployment/nfd-controller-manager
oc apply -f "${prereqs}/nfd/nodefeaturediscovery.yaml"
