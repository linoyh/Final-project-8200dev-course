pipeline {

    agent any

    environment {
        dockerhub_registry = '6419/attendance_app_bynet'
        dockerhub_credential = credentials('dockerhub')
        dockerImage = ''
        //dockerTagImage = ''
        github_credential = 'a0bb4e47-f112-4b84-9e36-1fb1d2239d7e'
        github_url = 'https://github.com/linoyh/Final-project-8200dev-course'
        test_cerdentials = 'jenkins-ec2-server-credentials'
        //prod_cerdentials =
    }
    stages {
        stage('Build BE Image') {
            steps {
                script {
                    //dockerImage = docker.build(dockerhub_registry:${env.BUILD_ID}, "./app")
                    dockerImage = docker.build(dockerhub_registry + "latest", "./app")
                    //dockerTagImage = docker.build(dockerHubRegistry + ":${env.BUILD_NUMBER}", "./app")
                }
            }
        }
        stage('test') {
            steps {
                sshagent(credentials: [test_cerdentials]) {
                    sh """
                        echo 'connecting to test server'
                        bash -x deploy.sh test
                        """
                    }
                }
            }
            //docker login
            // docker push 6419/attendance_app_bynet:app-image
            stage('push to dockerhub') {
                steps {
                    script {
                        docker.withRegistry( '', dockerhub_credential) {
                            dockerImage.push()
                        }
                    }
                }
            }
        }
    }
