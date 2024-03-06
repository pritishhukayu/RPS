def argocdServer = "172.16.9.183:30013"
def argocdAppName = params.argocd_appName
def argocdJenkinsDeployRole = params.argocd_jenkinsDeployRole

pipeline {
    agent any
  
    environment {
        DOCKER_IMAGE_NAME = 'rps-web-app'
        DOCKER_IMAGE_TAG = 'latest'
        GIT_SSL_NO_VERIFY = 'true'
    }
    
    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    sh 'echo "Docker stopped"'
                    //sh "docker build -t $DOCKER_IMAGE_NAME:$DOCKER_IMAGE_TAG ."
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
        
        stage("Refresh k8s container") {
            steps {
                retry(count: 2) {
                    script {
                        withCredentials([string(credentialsId: "${argocdJenkinsDeployRole}", variable: 'ARGOCD_AUTH_TOKEN')]) {
                            sh """
                                ARGOCD_SERVER=${argocdServer} argocd app actions run ${argocdAppName} restart --kind StatefulSet
                                ARGOCD_SERVER=${argocdServer} argocd --grpc-web app sync ${argocdAppName} --force
                                ARGOCD_SERVER=${argocdServer} argocd --grpc-web app wait ${argocdAppName} --timeout 600
                            """
                        }
                    }
                }
            }
        }
    }
}
