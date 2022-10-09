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
                        docker.withRegistry(registry, registryCredential) {
                            dockerImage = docker.build registry + "/jenkins/" + CONTAINER_NAME +":$BUILD_NUMBER"
                        }
                    }
                }
            }

            stage('Deploying Docker Image to Nexus') {
                steps {
                    script {
                        docker.withRegistry(registry, registryCredential) {
                            dockerImage.push()
                        }
                    }
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