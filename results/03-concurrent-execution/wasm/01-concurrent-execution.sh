#!/bin/bash

for test_type in # fuzzysearch whatlang prime-numbers n-body matmul linear-equations float-operation aes user-manager
do
  echo "Testing $test_type..."
     if [ $test_type == "aes" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://aes.l26.mrezhi.net/?length=1000&iterations=100" > $test_type-concurrent-execution.csv
     elif [ $test_type == "float-operation" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://float-operation.l26.mrezhi.net/?n=10000000" > $test_type-concurrent-execution.csv
     elif [ $test_type == "linear-equations" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://linear-equations.l26.mrezhi.net/?unknowns=128" > $test_type-concurrent-execution.csv
     elif [ $test_type == "matmul" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://matmul.l26.mrezhi.net/?dimensions=50" > $test_type-concurrent-execution.csv
     elif [ $test_type == "fuzzysearch" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://fuzzysearch-http.l26.mrezhi.net/?search=Hamlet" > $test_type-concurrent-execution.csv
     elif [ $test_type == "n-body" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://n-body.l26.mrezhi.net/" > $test_type-concurrent-execution.csv
     elif [ $test_type == "prime-numbers" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://prime-numbers.l26.mrezhi.net/?n=100" > $test_type-concurrent-execution.csv
     elif [ $test_type == "whatlang" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://whatlang.l26.mrezhi.net/?text=The%20quick%20brown%20fox%20jumps%20over%20the%20lazy%20dog" > $test_type-concurrent-execution.csv
     elif [ $test_type == "user-manager" ]; then
       hey -c 5 -q 5 -z 1m -m GET -t 0 -disable-keepalive -o csv "https://user-manager.l26.mrezhi.net/?entries=1" > $test_type-concurrent-execution.csv
     fi
done
