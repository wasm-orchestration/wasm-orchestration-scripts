#!/bin/bash

for test_type in aes float-operation user-manager whatlang prime-numbers n-body fuzzysearch matmul linear-equations
do
  sleep 10
  echo "Testing $test_type..."
     if [ $test_type == "aes" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/aes?length=1000&iterations=100" > $test_type-serial.csv
     elif [ $test_type == "float-operation" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/float-operation?n=10000000" > $test_type-serial.csv
     elif [ $test_type == "linear-equations" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/linear-equations?unknowns=128" > $test_type-serial.csv
     elif [ $test_type == "matmul" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/matmul?dimensions=50" > $test_type-serial.csv
     elif [ $test_type == "fuzzysearch" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/fuzzysearch-http" > $test_type-serial.csv
     elif [ $test_type == "n-body" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/n-body" > $test_type-serial.csv
     elif [ $test_type == "prime-numbers" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/prime-numbers" > $test_type-serial.csv
     elif [ $test_type == "whatlang" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/whatlang" > $test_type-serial.csv
     elif [ $test_type == "user-manager" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://gateway.l26.mrezhi.net/function/user-manager" > $test_type-serial.csv
     fi
done
