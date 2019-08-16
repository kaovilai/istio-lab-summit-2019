#!/bin/sh

export CURL_POD=$(oc get pods -n istio-tutorial -l app=curl | grep curl | awk '{ print $1}' )
export CUSTOMER_POD=$(oc get pods -n istio-tutorial -l app=customer | grep customer | awk '{ print $1}' )

echo "A load generating script is running in the next step. Ctrl+C to stop"

while :; do 

# echo "Executing curl in curl pod"
oc exec -n istio-tutorial $CURL_POD curl http://preference:8080 &> /dev/null 

# echo "Executing curl in customer pod"
oc exec -n istio-tutorial $CUSTOMER_POD -c customer curl http://preference:8080 &> /dev/null 

done

