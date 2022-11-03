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

#creating final-project dir on the test server
echo "creatinf ginal-project dir in $machine machine"
ssh -i "${SECRET_KEY}" -o StrictHostKeyChecking=no ec2-user@${machine} "mkdir -p ${HOME_DIR}/final-project-linoy-bynet"
# ssh -i .ssh/jenkins-git -o StrictHostKeyChecking=no ec2-user@172.31.84.178 mkdir /home/ec2-user/final-project

#copy docker-compose.yaml file to machine final-project dir using scp
echo "copying docker-compose file to $machine"
scp -i "${SECRET_KEY}" "${JENKINS_PIPELINE_WORKSPACE}/docker-compose.yaml"  "${machine}:${HOME_DIR}/final-project-linoy-bynet"

#ssh to the $machine (test ot prod) and bring the application up, the EOF enable run multiple commands via ssh in the remote server
ssh -i "${SECRET_KEY}" -o StrictHostKeyChecking=no ec2-user@${machine} << EOF
cd $HOME_DIR/final-project-linoy-bynet
docker-compose -f docker-compose.yaml up --build
EOF

echo "Deploying to $machine server succedded"


scp -i "${SECRET_KEY}" "${JENKINS_PIPELINE_WORKSPACE}/docker-compose.yaml"  "${machine}:${HOME_DIR}/final-project"
echo "starting project"


