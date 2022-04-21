pipeline {
    agent any
    stages {
        stage("clone") {
            steps {
                echo "cloning the repo"
            }
        }
        stage("build") {
            steps {
                echo "Building the node app image"
            }
        }
        stage("push") {
            steps {
                echo "Push the Docker image to Docker Hub"
            }
            steps {
                echo "Push helm dir to the Helm Hub"
            }
        }
    }
} 