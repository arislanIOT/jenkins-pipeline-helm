#!/bin/bash

sed "s/tagVersion/$1/g" sample.yaml  > node-app/values.yaml
