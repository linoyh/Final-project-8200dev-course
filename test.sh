#!/bin/bash

MA="test"
if [ "$MA" == "test" ];
then
    HTT=`curl --write-out "%{http_code}\n" --silent --output /dev/null "http://127.0.0.1:5000"`
    echo $HTT
    if [ "$HTT" == "200" ];
    then
echo "Test succedded"
    else
echo "Test failed"
    fi
fi

#!/bin/bash

MA="test"
if [ "$MA" == "test" ];
then
    HTT=`curl --write-out "%{http_code}\n" --silent --output /dev/null "http://127.0.0.1:5000"`
    echo $HTT
    if [ "$HTT" == "200" ];
    then
      echo "Test succedded"
    else
      echo "Test failed"
    fi
fi