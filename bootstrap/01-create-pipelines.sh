#!/bin/bash

oc new-project flyingthings-standalone

cd ../pipelines/manifests
oc apply -f .

cd ../runs
oc apply -f .