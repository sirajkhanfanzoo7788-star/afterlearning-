pipeline {
    agent any

    environment {
        IMAGE_NAME = "sirajahmad77/afterlearning"
        BUILD_TAG = "${BUILD_NUMBER}"  // Jenkins build number as Docker tag
    }

    stages {
        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME%:%BUILD_TAG% ."
            }
        }

        stage('Push Docker Image') {
            steps {
                bat "docker push %IMAGE_NAME%:%BUILD_TAG%"
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                // Replace BUILD_NUMBER in YAML with actual tag (Windows syntax)
                bat "(Get-Content deployment.yaml) -replace 'BUILD_NUMBER', '%BUILD_TAG%' | Set-Content deployment_temp.yaml"

                // Apply the updated YAML
                bat "kubectl apply -f deployment_temp.yaml"
            }
        }
    }
}
