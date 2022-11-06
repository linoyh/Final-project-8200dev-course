#!/usr/bin/bash

#  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #
#this script deploy the final project into test and production servers  #
#  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #

# Gobal Variables
HOME_DIR="/home/ec2-user"
JENKINS_PIPELINE_WORKSPACE="/var/lib/jenkins/workspace/final-project-8200dev"
SECRET_KEY="${HOME_DIR}/.ssh/jenkins-git"

#takes the first argument ($1) check if it is test or prod machine
machine=$1

#ptints wheather I deploy to test or prod
echo "Deploying to $machine starting"

#copy final-project dir on the test or prod server by scp
echo "copying final-project dir in $machine machine"
scp -o StrictHostKeyChecking=no -r "$JENKINS_PIPELINE_WORKSPACE" ec2-user@${machine}:~
#ssh -i "${SECRET_KEY}" -o StrictHostKeyChecking=no ec2-user@${machine} "mkdir -p ${HOME_DIR}/final-project-linoy-bynet"
# ssh -i .ssh/jenkins-git -o StrictHostKeyChecking=no ec2-user@172.31.84.178 mkdir /home/ec2-user/final-project


#ssh to the $machine (test ot prod):
# copy the .env.py file (I created manually becuse I have not upload it to git) to the project dir
# bring the application up
# the EOF enable run multiple commands via ssh in the remote server
#"cp .env.py final-project-8200dev/ && cd /home/ec2-user/final-project-8200dev/ && docker-compose up --build -d && curl http://127.0.0.1:5000"


ssh -o StrictHostKeyChecking=no ec2-user@${machine} << 'EOF'
  cp .env.py final-project-8200dev/
  cd /home/ec2-user/final-project-8200dev/
  docker-compose up --build -d
  sleep 20
  if [ "$machine" -eq "test" ];
  then
      http_status = `curl --write-out "%{http_code}\n" --silent --output /dev/null "http://127.0.0.1:5000"`
      if [ "$http_status" -eq 200 ];
      then
        echo "Test succedded"
      else
        echo "Test failed"
      fi
  fi
EOF

echo "Deploying to $machine server succedded"

#check if the current server is test. if does run test.sh script on the test server
#if [ $machine == "test" ]
#then
#  ssh -i "${SECRET_KEY}" -o StrictHostKeyChecking=no ec2-user@${machine} './test.sh'
#elif

#fi

