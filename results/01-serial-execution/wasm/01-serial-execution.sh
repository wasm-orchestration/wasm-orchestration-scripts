#!/bin/bash

# for test_type in aes float-operation user-manager whatlang prime-numbers n-body fuzzysearch matmul linear-equations
for test_type in user-manager
do
  echo "Testing $test_type..."
     if [ $test_type == "aes" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://aes.l26.mrezhi.net/?length=1000&iterations=100" > $test_type-serial.csv
     elif [ $test_type == "float-operation" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://float-operation.l26.mrezhi.net/?n=10000000" > $test_type-serial.csv
     elif [ $test_type == "linear-equations" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://linear-equations.l26.mrezhi.net/?unknowns=128" > $test_type-serial.csv
     elif [ $test_type == "matmul" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://matmul.l26.mrezhi.net/?dimensions=50" > $test_type-serial.csv
     elif [ $test_type == "fuzzysearch" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://fuzzysearch-http.l26.mrezhi.net/?search=Hamlet" > $test_type-serial.csv
     elif [ $test_type == "n-body" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://n-body.l26.mrezhi.net/" > $test_type-serial.csv
     elif [ $test_type == "prime-numbers" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://prime-numbers.l26.mrezhi.net/?n=100" > $test_type-serial.csv
     elif [ $test_type == "whatlang" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://whatlang.l26.mrezhi.net/?text=The%20quick%20brown%20fox%20jumps%20over%20the%20lazy%20dog" > $test_type-serial.csv
     elif [ $test_type == "user-manager" ]; then
       hey -disable-keepalive -z 5m -c 1 -t 0 -o csv -m GET "https://user-manager.l26.mrezhi.net/?entries=1" > $test_type-serial.csv
     fi
done
