pipeline {

    agent any

    environment {
        dockerhub_registry = '6419/attendance_app_bynet'
        dockerhub_credential = 'dockerhub'
        dockerImage = ''
        dockerTagImage = ''
        github_url = 'https://github.com/linoyh/Final-project-8200dev-course'
        jenkins_cerdentials_private_key = 'jenkins-ec2-server-credentials'
    }
    stages {
        stage('Build BE Image') {
            steps {
                script {
                    //dockerImage = docker.build(dockerhub_registry + ":${BUILD_NUMBER}", "./app")
                    dockerTagImage = docker.build(dockerhub_registry + ":latest", "./app")
                }
            }
        }
        stage('Deploy To Test') {
            steps {
                sshagent(credentials: [jenkins_cerdentials_private_key]) {
                    sh """
                        echo 'connecting to test server'
                        bash -x deploy.sh test
                        """
                    }
                }
            }
            stage('Push To Dockerhub') {
                steps {
                    script {
                        docker.withRegistry( '', dockerhub_credential) {
                            dockerTagImage.push()
                        }
                    }
                }
            }
            stage('Deploy To Production') {
            steps {
                sshagent(credentials: [jenkins_cerdentials_private_key]) {
                    sh """
                        echo 'connecting to production server'
                        bash -x deploy.sh production
                        """
                    }
                }
            }
        }
    }


