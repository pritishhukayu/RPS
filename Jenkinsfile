pipeline {
    agent any

    environment {
        DOCKER_IMAGE_NAME = 'rps-web-app'
        DOCKER_IMAGE_TAG = 'latest'
         //ArgoCD details
        ARGOCD_URL = 'http://172.16.9.183:30013' // Replace with your ArgoCD server URL
        ARGOCD_PROJECT = 'voltas-amc' // Replace with your ArgoCD project name
        ARGOCD_APP_NAME = 'testargoautomate' // Replace with your ArgoCD application name
        // Credentials
        ARGOCD_TOKEN = credentials('Argocd-Deploy-Role') // Replace with your ArgoCD token credential ID
    }

    stages {
        stage('Build') {
            steps {
                script {
                    // Build the Docker image
                    //sh "docker build -t ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG} ."
                    // Optionally push the image to a Docker registry
                    // sh "docker push ${DOCKER_IMAGE_NAME}:${DOCKER_IMAGE_TAG}"
                }
            }
        }

        stage('Test') {
            steps {
                // Your actual test steps here
                sh 'echo "Running tests"'
            }
        }

        stage('Deploy to ArgoCD') {
            steps {
                script {
                    // Use Argo CD Plugin for authentication and application management
                    def argo = Artifactory.newArtifactory(url: ARGOCD_URL, credentialsId: 'argocd-token')
                    argo.login(password: ARGOCD_TOKEN, project: ARGOCD_PROJECT)

                    def application = argo.application(name: ARGOCD_APP_NAME)
                    if (application == null) {
                        application = argo.createApplication(name: ARGOCD_APP_NAME, source: [
                            chart: '',
                            helm: '',
                            kustomize: './' // Path to your Kubernetes manifests directory
                        ])
                    }

                    application.sync()
                }
            }
        }
    }
}
