#!/bin/bash

sed "s/tagVersion/$1/g" node-app/sample.yaml  > node-app/values.yaml
