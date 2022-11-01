pipeline {

    agent any

    environment {
        dockerhub_registry = '6419/attendance_app_bynet'
        dockerhub_credential = credentials('dockerhub')
        dockerImage = ''
        github_credential = 'a0bb4e47-f112-4b84-9e36-1fb1d2239d7e'
        github_url = 'https://github.com/linoyh/Attendance-project.git'
        test_cerdentials = 'jenkins-ec2-server-credentials'
        //prod_cerdentials =
    }
    stages {
        stage ('Build BE Image') {
            steps {
                script {
                    dockerImage = docker.build dockerhub_registry + ":latest"
                    }
                }
            }
        }
        stage ('push to dockerhub') {
            steps {
               script {
                    docker.withRegistry( '', dockerhub_credential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage ('pull from dockerHub') {
            steps {
               script {
                    docker.withRegistry( '', dockerHubRegistryCredential ) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage ('test') {
            steps {
                sshagent(credentials: [test_cerdentials]) {
                    sh """
                        echo 'test server in action'
                        ssh -o StrictHostKeyChecking=no -i /home/ec2-user/.ssh/jenkins-git
                        bash -x deploy.sh test
                        """
                    }
                }
            }
        }
