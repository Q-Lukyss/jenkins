pipeline {
    agent any

    environment {
        IMAGE_NAME = "mon_premier_ci_cd"
        CONTAINER_NAME = "mon_serveur_web"
        // Désactiver TLS pour Docker
        DOCKER_CERT_PATH = ""
        DOCKER_TLS_VERIFY = ""
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Q-Lukyss/jenkins'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:1")
                }
            }
        }
        stage('Stop Old Container') {
            steps {
                sh """
                if [ \$(docker ps -q -f name=${CONTAINER_NAME}) ]; then
                  docker stop ${CONTAINER_NAME}
                fi
                if [ \$(docker ps -aq -f name=${CONTAINER_NAME}) ]; then
                  docker rm ${CONTAINER_NAME}
                fi
                """
            }
        }
        stage('Run Docker Container') {
            steps {
                sh "docker run -d --name ${CONTAINER_NAME} -p 8080:80 ${IMAGE_NAME}:1"
            }
        }
    }
}
