#!/bin/bash

ITERATIONS=100
NAMESPACE=webassembly

for test_type in user-manager whatlang fuzzysearch linear-equations aes float-operation matmul prime-numbers n-body
do
  echo "Testing $test_type..."
  echo "Database maintenance completed?"
  read db_maintenance_completed

     if [ $test_type == "aes" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://aes.l26.mrezhi.net/?length=1000&iterations=100" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "float-operation" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://float-operation.l26.mrezhi.net/?n=10000000" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "linear-equations" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://linear-equations.l26.mrezhi.net/?unknowns=128" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "matmul" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://matmul.l26.mrezhi.net/?dimensions=50" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "fuzzysearch" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://fuzzysearch-http.l26.mrezhi.net/?search=Hamlet" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "n-body" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://n-body.l26.mrezhi.net/" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "prime-numbers" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://prime-numbers.l26.mrezhi.net/?n=100" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "whatlang" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://whatlang.l26.mrezhi.net/?text=The%20quick%20brown%20fox%20jumps%20over%20the%20lazy%20dog" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "user-manager" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 5 seconds..."
             sleep 5
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://user-manager.l26.mrezhi.net/?entries=1" >> $test_type-function-deployment.csv
         done
     fi
done
