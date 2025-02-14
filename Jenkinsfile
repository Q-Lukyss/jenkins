/* Requires the Docker Pipeline plugin */
pipeline {
    agent { docker { image 'golang:1.24.0-alpine3.21' } }
    stages {
        stage('build') {
            steps {
                sh 'go version'
            }
        }
    }
}

