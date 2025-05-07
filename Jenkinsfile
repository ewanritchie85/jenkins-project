pipeline {
    agent any

    environment {
        AWS_REGION = 'eu-west-2'
        IMAGE_TAG = 'latest'
    }

    stages {
        stage('Init Vars') {
            steps {
                withCredentials([string(credentialsId: 'AWS_ACCOUNT_ID', variable: 'AWS_ACCOUNT_ID')]) {
                    script {
                        env.ECR_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
                        env.IMAGE_NAME = "${env.ECR_URL}/ewan/jenkins-repo"
                    }
                }
            }
        }

        stage('Checkout') {
            steps {
                echo " *** checking out application repo ***"
                checkout scmGit(
                    branches: [[name: '*/main']],
                    extensions: [],
                    userRemoteConfigs: [[url: 'https://github.com/ewanritchie85/jenkins-project/']]
                )
                echo "*** application repo checked out ***"
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
                echo "*** pushing docker image to ECR ***"
                withAWS(credentials: 'ECR_CREDENTIALS', region: "${AWS_REGION}") {
                    sh """
                        aws ecr get-login-password --region ${AWS_REGION} | \
                        docker login --username AWS --password-stdin ${ECR_URL}
                        docker push ${IMAGE_NAME}:${IMAGE_TAG}
                    """
                }
                echo "*** docker image pushed to ECR ***"
            }
        }

        stage('Terraform init') {
            steps {
                dir('terraform') {
                    withAWS(credentials: 'ECR_CREDENTIALS') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform apply') {
            steps {
                dir('terraform') {
                    withAWS(credentials: 'ECR_CREDENTIALS') {
                        sh 'terraform apply --auto-approve'
                    }
                }
            }
        }

        stage('Build Frontend') {
            steps {
                echo "*** building frontend ***"
                dir('frontend') {
                    sh 'npm ci'
                    sh 'npm run build'
                }
                echo "*** frontend built ***"
            }
        }

        stage('Upload Frontend to S3') {
            steps {
                withAWS(credentials: 'ECR_CREDENTIALS', region: "${AWS_REGION}") {
                    sh 'aws s3 sync frontend/dist s3://ewan-frontend-bucket --delete'
                }
            }
        }
    }
}
