#!/usr/bin/bash
#-xe

#  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #
#this script deploy the final project into test and production servers  #
#  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #

# Gobal Variables
HOME_DIR="/home/ec2-user"
JENKINS_PIPELINE_WORKSPACE="/var/lib/jenkins/workspace/final-project-8200dev"
SECRET_KEY="${HOME_DIR}/.ssh/jenkins-git"

#takes the first argument ($1) check if it is test or prod machine
MACHINE=$1

#ptints wheather I deploy to test or prod
echo "Deploying to $machine starting"

#copy final-project dir on the test or prod server by scp
echo "copying final-project dir in $MACHINE machine"
scp -o StrictHostKeyChecking=no -r "$JENKINS_PIPELINE_WORKSPACE" ec2-user@${MACHINE}:~

#ssh to the $machine (test ot prod):
# copy the .env.py file (I created manually becuse I have not upload it to git) to the project dir
# bring the application up
# the EOF enable run multiple commands via ssh in the remote server
#"cp .env.py final-project-8200dev/ && cd /home/ec2-user/final-project-8200dev/ && docker-compose up --build -d && curl http://127.0.0.1:5000"


#docker pull 6419/attendance_app_bynet:latest
# docker-compose up --no-build -d
#  docker-compose up --build -d
#  docker-compose up --build -d
#  #  HTTP=`curl -I "http://127.0.0.1:5000"`

ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} "cp .env.py final-project-8200dev/ && cd /home/ec2-user/final-project-8200dev/ && docker pull 6419/attendance_app_bynet:latest && docker-compose up -d --no-build && sleep 30 && docker container ls -a"

if [ "$MACHINE" == "test" ];
then
    #echo "Testing"
    ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} "curl -I "http://127.0.0.1:5000"
fi

echo "Deploying to $MACHINE server succedded"

echo "Stating cleanup in $MACHINE"

ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} "docker-compose down && docker volume prune -f && docker rmi 6419/attendance_app_bynet && cd .. && rm -rf final-project-8200dev/"