#!/bin/bash

ITERATIONS=100
NAMESPACE=openfaas-fn

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
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/aes?length=1000&iterations=100" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "float-operation" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/float-operation?n=10000000" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "linear-equations" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/linear-equations?unknowns=128" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "matmul" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/matmul?dimensions=50" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "fuzzysearch" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/fuzzysearch-http" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "n-body" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/n-body" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "prime-numbers" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/prime-numbers" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "whatlang" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/whatlang" >> $test_type-function-deployment.csv
         done
     elif [ $test_type == "user-manager" ]; then
         for ((i=1; i<=$ITERATIONS; i++)); do
             echo "Run: $i for $test_type"
             pod_name=$(kubectl get pod -n $NAMESPACE | grep $test_type | awk '{print $1}')
             echo -e "\tDeleting $pod_name"
             line=$(kubectl delete pod -n $NAMESPACE $pod_name)
             echo -e "\t$line"
             echo -e "\tSleeping for 10 seconds..."
             sleep 10
             echo -e "\tInvoking function $test_type"
             hey -disable-keepalive -o csv -n 1 -c 1 -t 0 -m GET "https://gateway.l26.mrezhi.net/function/user-manager" >> $test_type-function-deployment.csv
         done
     fi
done
