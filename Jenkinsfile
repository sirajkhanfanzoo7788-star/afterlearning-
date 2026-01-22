pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "sirajahmad77"
        IMAGE_NAME     = "afterlearning"
        IMAGE_TAG      = "${BUILD_NUMBER}"
    }

    stages {

        stage('Build Docker Image') {
            steps {
                // Use env variables
                bat "docker build -t ${env.DOCKERHUB_USER}/${env.IMAGE_NAME}:${env.IMAGE_TAG} ."
            }
        }

        stage('Login to Docker Hub') {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: 'dockerhub-creds', 
                        usernameVariable: 'DOCKER_USER', 
                        passwordVariable: 'DOCKER_PASS'
                    )
                ]) {
                    // Secure login
                    bat "echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin"
                }
            }
        }

        stage('Push Image') {
            steps {
                bat "docker push ${env.DOCKERHUB_USER}/${env.IMAGE_NAME}:${env.IMAGE_TAG}"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                bat "kubectl apply -f deployment.yaml"
                bat "kubectl apply -f service.yaml"
            }
        }
    }
}
