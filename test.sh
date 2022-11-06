#!/bin/bash

http_status = `curl --write-out "%{http_code}\n" --silent --output /dev/null "http://127.0.0.1:5000"`

if [ $http_status -eq 200 ];
then
    echo "Test succedded"
else
  echo "Test failed"
fi