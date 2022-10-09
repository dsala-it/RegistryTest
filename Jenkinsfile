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
                        dockerImage = docker.build(registry + "/jenkins/node:$BUILD_NUMBER")
                    }
                }
            }
        }
        
        stage('Test Docker image') {
            dockerImage.inside {
                sh 'echo "Tests passed"'
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