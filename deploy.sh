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
echo "deloy to $machine"

echo "creating project dir"

ssh -i "${SECRET_KEY}" -o StrictHostKeyChecking=no ${machine} "mkdir -p ${HOME_DIR}/final-project"

echo "copying compose file to $machine"

echo "Deploying to production server"


scp -i "${SECRET_KEY}" "${JENKINS_PIPELINE_WORKSPACE}/docker-compose.yaml"  "${machine}:${HOME_DIR}/final-project"
echo "starting project"

ssh -i /home/ec2-user/.ssh/id_dsa $USER@$machine "cd $HOME_DIR/Flask-app-AWS && docker-compose up"

scp -i /home/ec2-user/.ssh/id_dsa -r /var/lib/jenkins/workspace/* ec2-user@prod:~
ssh -i /home/ec2-user/.ssh/id_dsa $USER@$machine "cd $HOME_DIR/Flask-app-AWS && docker-compose up"


