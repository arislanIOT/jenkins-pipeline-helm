pipeline {
    agent any
    stages {
        stage("clone") {
            steps {
                echo "cloning the repo"
                git 'https://github.com/arislanIOT/get-started-node.git'
            }
        }
        stage("build") {
            steps {
                echo "Building the node app image"
                sh "docker build --tag mynode ."
            }
        }
        stage("push") {
            steps {
                echo "Push the Docker image to Docker Hub"
            }
            
        }
    }
} 