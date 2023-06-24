#!/bin/bash

spin build
mv main.wasm build/
cd build
docker build -t artifacts.apps.mrezhi.net/wasm/spin/go/matmul:v1 .
sudo docker push artifacts.apps.mrezhi.net/wasm/spin/go/matmul:v1
