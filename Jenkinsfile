pipeline {
    agent any

    environment {
        IMAGE_NAME = 'ewan/jenkins-repo'
        IMAGE_TAG = 'latest'
        AWS_REGION = "eu-west-2"
        AWS_ACCOUNT_ID = '654463037626'
        ECR_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    }

    stages {
        stage('Checkout') {
            steps {
                echo " *** checking out repo ***"
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [], 
                    userRemoteConfigs: [[url: 'https://github.com/ewanritchie85/jenkins-project/']]
                )
                echo "*** repo checked out ***"
            }
        }

        stage('Docker Build') {
            steps {
                echo "*** building docker image ***"
                script {
                    docker.build("${IMAGE_NAME}", "./backend")
                }
                echo "*** docker image built ***"
            }
        }

        stage('Docker Push to ECR') {
            steps {
                script {
                    docker.withRegistry("https://${ECR_URL}", 'ecr:eu-west-2:654463037626') {
                        docker.image("${IMAGE_NAME}").push("${IMAGE_TAG}")
                    }
                }
            }
        }

        stage('Terraform init') {
            steps {
                dir('terraform'){
                    withAWS(credentials:'654463037626') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform apply') {
            steps {
                dir('terraform'){
                    withAWS(credentials:'654463037626'){
                sh 'terraform apply --auto-approve'
                    }
                }
            }
        }
        
}
}