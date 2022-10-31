#!/usr/bin/bash

#  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #
#this script deploy the final project into test and production servers  #
#  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #  #  #  #  #  #  # #  #
# Gobal Variables
HOME_DIR="/home/ec2-user"
JENKINS_PIPELINE_WORKSPACE="/var/lib/jenkins/workspace/final-project"
$SECRET_KEY="${HOME_DIR}/.ssh/jenkins-git"

machine=$1

echo "deloy to $machine"
echo "creating project dir"

ssh -i StrictHostKeyChecking=no -l ec2user test mkdir linoy""" )

