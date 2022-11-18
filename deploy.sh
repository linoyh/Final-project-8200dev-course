#!/usr/bin/bash -xe

#  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #
#this script deploy the final project into test and production servers  #
#  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #

# Gobal Variables
HOME_DIR="/home/ec2-user"
JENKINS_PIPELINE_WORKSPACE="/var/lib/jenkins/workspace/final-project-8200dev"
SECRET_KEY="${HOME_DIR}/.ssh/jenkins-git"

#takes the first argument ($1) check if it is test or prod machine
MACHINE=$1
IMAGE_TAG=$2

#ptints wheather I deploy to test or prod
echo "Deploying to $machine starting"

#copy final-project dir on the test or prod server by scp
echo "copying final-project dir in $MACHINE machine"
scp -o StrictHostKeyChecking=no -r "$JENKINS_PIPELINE_WORKSPACE" ec2-user@${MACHINE}:~

#ssh to the $machine (test ot prod):
# copy the .env.py file (I created manually becuse I have not upload it to git) to the project dir
# pull docker image from docker hub
# bring the application up

ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} "cp .env.py final-project-8200dev/ && cd /home/ec2-user/final-project-8200dev/ && docker pull 6419/attendance_app_bynet:$IMAGE_TAG && docker-compose up -d --no-build && sleep 80 && docker container ls -a"

# check wether the server is test if does run the check statuss
if [ "$MACHINE" == "test" ];
then
    echo "Testing"
    ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} "curl -I "http://127.0.0.1:5000""
fi

echo "Deploying to $MACHINE server succedded"

OLD_TAG=$((IMAGE_TAG-1))

#cleanup the server- test / prod
echo "Stating cleanup in $MACHINE"
ssh -o StrictHostKeyChecking=no ec2-user@${MACHINE} "cd /home/ec2-user/final-project-8200dev/ && docker-compose down && docker volume prune -f && docker rmi 6419/attendance_app_bynet:$OLD_TAG && cd .. && rm -rf final-project-8200dev/"