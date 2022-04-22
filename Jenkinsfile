pipeline {
    agent any
    environment {
        DOCKER_TAG = getDockerTag()
    }
    stages {
        // stage("clone") {
        //     steps {
        //         echo "cloning the repo"
        //         git 'https://github.com/arislanIOT/jenkins-pipeline-helm.git'
        //     }
        // }
        stage("Container build") {
            steps {
                echo "Building the node app image"
                sh "docker build . --tag arislankareem/jenkins-pipeline-helm:${DOCKER_TAG}"
            }
        }
        stage("push") {
            steps {
                echo "Push the Docker image to Docker Hub"
                withCredentials([usernamePassword(credentialsId: 'docker-hub', passwordVariable: 'dockerHubPwd', usernameVariable: 'USERNAME')]) {
                    sh "docker login -u ${USERNAME} -p ${dockerHubPwd}"
                    sh "docker push arislankareem/jenkins-pipeline-helm:${DOCKER_TAG}"

                }
                
            }
            
        }
        stage("Updating image tag") {
            steps{
                echo "Updating lateset image to values yaml"
                sh "chmod +x tagupdate.sh"
                sh "./tagupdate.sh ${DOCKER_TAG}"

            }
        }
        stage("Packaging") {
            steps {
                echo "Packaging helm chart"
                sh "helm package node-app"
            }
        }
    }
} 


def getDockerTag() {
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}
