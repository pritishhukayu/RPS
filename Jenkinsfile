def argocdServer = params.argocd_server
def argocdAppName = params.argocd_appName
def argocdJenkinsDeployRole = params.argocd_jenkinsDeployRole

pipeline {
    agent any
  
    environment {
        DOCKER_IMAGE_NAME = 'rps-web-app'
        DOCKER_IMAGE_TAG = 'latest'
    }
    
    stages {
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
