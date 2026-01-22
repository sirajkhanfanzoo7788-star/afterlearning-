pipeline {
    agent any

    environment {
        DOCKERHUB_USER = "sirajahmad77"
        IMAGE_NAME     = "afterlearning"
        IMAGE_TAG      = "${BUILD_NUMBER}"
        KUBECONFIG     = "C:\\Users\\M SIRAJ RAHIM\\.kube\\config"  // Minikube kubeconfig path
    }

    stages {

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKERHUB_USER%/%IMAGE_NAME%:%IMAGE_TAG% ."
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
                    bat "echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin"
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                bat "docker push %DOCKERHUB_USER%/%IMAGE_NAME%:%IMAGE_TAG%"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Make Jenkins use your Minikube kubeconfig
                bat "kubectl --kubeconfig=%KUBECONFIG% apply -f deployment.yaml"
                bat "kubectl --kubeconfig=%KUBECONFIG% apply -f service.yaml"
            }
        }
    }
}
