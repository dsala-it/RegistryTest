def CONTAINER_NAME="node"
def CONTAINER_TAG="latest"

pipeline {
    environment {
    registry = "docker.digitastuces.com"
    registryCredential = 'jennexus-cicd'
    dockerImage = ''
    }

    agent any
    stages {
            stage('Cloning Git') {
                // git credentialsId: 'dsala-it-github', url: 'https://github.com/dsala-it/RegistryTest'
                steps {
                    git branch: 'master',
                        credentialsId: 'dsala-it-github',
                        url: 'https://github.com/dsala-it/RegistryTest'

                    sh "ls -lat"
                }
            }

            stage('Building Docker Image') {
                steps {
                    script {
                        dockerImage = docker.build registry + ":$BUILD_NUMBER"
                    }
                }
            }

            stage('Sonar'){
                try {
                    //sh "mvn sonar:sonar"
                    sh "echo 'Quality'"
                } catch(error){
                    echo "The sonar server could not be reached ${error}"
                }
            }

            stage("Image Prune"){
                imagePrune(CONTAINER_NAME)
            }

            stage('Deploying Docker Image to Dockerhub') {
                steps {
                    script {
                        docker.withRegistry('', registryCredential) {
                        dockerImage.push()
                        }
                    }
                }
            }

            stage('Cleaning Up') {
                steps{
                  sh "docker rmi --force $registry:$BUILD_NUMBER"
                }
            }
        }
    }


def imagePrune(containerName){
    try {
        sh "docker image prune -f"
        sh "docker stop $containerName"
    } catch(error){}
}