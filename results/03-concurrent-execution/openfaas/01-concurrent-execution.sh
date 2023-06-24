#!/bin/bash

for test_type in n-body matmul linear-equations float-operation aes user-manager fuzzysearch whatlang prime-numbers
do
  sleep 10
  echo "Testing $test_type..."
     if [ $test_type == "aes" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/aes?length=1000&iterations=100" > $test_type-concurrent-execution.csv
     elif [ $test_type == "float-operation" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/float-operation?n=10000000" > $test_type-concurrent-execution.csv
     elif [ $test_type == "linear-equations" ]; thenh
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/linear-equations?unknowns=128" > $test_type-concurrent-execution.csv
     elif [ $test_type == "matmul" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/matmul?dimensions=50" > $test_type-concurrent-execution.csv
     elif [ $test_type == "fuzzysearch" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/fuzzysearch-http" > $test_type-concurrent-execution.csv
     elif [ $test_type == "n-body" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/n-body" > $test_type-concurrent-execution.csv
     elif [ $test_type == "prime-numbers" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/prime-numbers" > $test_type-concurrent-execution.csv
     elif [ $test_type == "whatlang" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/whatlang" > $test_type-concurrent-execution.csv
     elif [ $test_type == "user-manager" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://gateway.l26.mrezhi.net/function/user-manager" > $test_type-concurrent-execution.csv
     fi
done
