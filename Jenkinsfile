pipeline {
    agent any
  
    environment {
        DOCKER_IMAGE_NAME = 'rps-web-app'
        DOCKER_IMAGE_TAG = 'latest'
    }
    
    stages {
        stage('Build') {
            steps {
                // Build the Docker image
                script {
                    sh 'docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG .'
                }
            }
        }
        
        stage('Test') {
            steps {
                // Your test steps
                sh 'echo "Running tests"'
            }
        }
    }
}
