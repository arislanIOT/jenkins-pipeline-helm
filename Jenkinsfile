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
        // stage("helm package push") {
        //     steps {
        //         echo "pushing the hel pakage to ECR"
        //         sh "helm push node-app-0.1.0.tgz oci://996166566464.dkr.ecr.us-west-2.amazonaws.com/"
        //     }
        // }
        stage("Deploy") {
            steps {
                echo "Sign in to EKS"
                withCredentials([usernamePassword(credentialsId: 'aws-api-key', passwordVariable: 'AWS_SECRET_ACCESS_KEY', usernameVariable: 'AWS_ACCESS_KEY_ID')]) {
                    sh "aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}"
                    sh "aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}"
                    sh "aws configure set region us-west-2"
                }
                echo "Deploying app to EKS"
                sh "aws ecr get-login-password --region us-west-2 | helm registry login --username AWS --password-stdin 996166566464.dkr.ecr.us-west-2.amazonaws.com"
                // sh "kubectl delete ns nodejsapp"
                // sh "kubectl create ns nodejsapp"
                // sh "helm uninstall my-eks-app --namespace nodejsapp"
                sh "sleep 5"

                sh "helm upgrade --install --atomic --timeout 600s --namespace nodejsapp my-eks-app node-app/"
            }
        }
    }
} 


def getDockerTag() {
    def tag = sh script: 'git rev-parse HEAD', returnStdout: true
    return tag
}


// withCredentials([usernamePassword(credentialsId: 'aws-api-key', passwordVariable: 'SECRET_KEY', usernameVariable: 'ACCESS_KEY')]) {
//     // some block
// }