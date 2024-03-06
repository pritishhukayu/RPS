pipeline {
    agent any
  
    environment {
        DOCKER_IMAGE_NAME = 'rps-web-app'
        DOCKER_IMAGE_TAG = 'latest'
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    sh "docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG ."
                    // Push the image to a Docker registry if needed
                    // sh "docker push $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG"
                }
            }
        }
        
        stage('Test') {
            steps {
                // Your actual test steps here
                sh 'echo "Running tests"'
            }
        }
    }
}
