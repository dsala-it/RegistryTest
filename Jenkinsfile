pipeline {
    environment {
        registry = "docker.digitastuces.com"
        registryCredential = 'jennexus-cicd'
        dockerImage = ''
    }

    agent any

    stages {
        stage('Checkout') {
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
                        //dockerImage = docker.build(registry + "/node:$BUILD_NUMBER")
                        dockerImage = docker.build("docker.digitastuces.com/node:latest")
                    }
                }
            }
        }
        
        stage('Test Docker image') {
            steps {
                script {
                    dockerImage.inside {
                        sh 'echo "Tests passed"'
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