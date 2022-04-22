pipeline {
    agent any
    environment {
        DOCKER_TAG = getDockerTag()
    }
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
                sh "docker build  --tag mynode:${DOCKER_TAG} Dockerfile"
            }
        }
        stage("push") {
            steps {
                echo "Push the Docker image to Docker Hub"
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerHubPwd', usernameVariable: 'USERNAME')]) {
                    sh "docker login -u ${USERNAME} -p ${dockerHubPwd}"
                    sh "docker push mynode:${DOCKER_TAG}"

                }
                
            }
            
        }
        stage("k8 deploy"){
            steps{
                echo "helm install <chartname>"
            }
        }
    }
} 


def getDockerTag() {
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}