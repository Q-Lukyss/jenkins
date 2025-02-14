pipeline {
    agent any

    environment {
        IMAGE_NAME = "mon_premier_ci_cd"
        CONTAINER_NAME = "mon_premier_ci_cd"
    }

    stages {
        stage('Checkout') {
            steps {
                // Clone le dépôt (la configuration peut varier selon ton système SCM)
                git branch: 'main', url: 'https://github.com/Q-Lukyss/jenkins'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    // Construire l'image Docker avec un tag basé sur le numéro de build
                    dockerImage = docker.build("${IMAGE_NAME}:${env.BUILD_NUMBER}")
                }
            }
        }
        stage('Stop Old Container') {
            steps {
                // Arrête et supprime l'ancien conteneur s'il existe
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
                // Lancer le nouveau conteneur
                sh "docker run -d --name ${CONTAINER_NAME} -p 8080:80 ${IMAGE_NAME}:${env.BUILD_NUMBER}"
            }
        }
    }
}
