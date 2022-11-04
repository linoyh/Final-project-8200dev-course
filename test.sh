#!/bin/bash

curl 127.0.0.1:5000
res=$?
if test "$res" != "0"; then
	echo "curl command failed : $res"
fi
	       sh ''' docker-compose up -d --build
		      sleep 15
	              HTTP_STATUS=`curl -o /dev/null -s -w "%{http_code}\n" http://localhost:5000/`
		      docker-compose down
		      if [ $HTTP_STATUS -eq 200 ];
		      then
		      		echo "TEST: SUCCES"
		      else
				echo "TEST: FAIL"
				exit 1
		      fi

