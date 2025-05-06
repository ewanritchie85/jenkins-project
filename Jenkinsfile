pipeline {
    agent any

environment {
    AWS_REGION = 'eu-west-2'
    AWS_ACCOUNT_ID = '654463037626'
    ECR_URL = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_REGION}.amazonaws.com"
    IMAGE_NAME = "${ECR_URL}/ewan/jenkins-repo"
    IMAGE_TAG = 'latest'
}


    stages {
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
                echo "*** docker image built **"
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
                dir('terraform'){
                    withAWS(credentials:'ECR_CREDENTIALS') {
                        sh 'terraform init'
                    }
                }
            }
        }

        stage('Terraform apply') {
            steps {
                dir('terraform'){
                    withAWS(credentials:'ECR_CREDENTIALS'){
                sh 'terraform apply --auto-approve'
                    }
                }
            }
        }

stage('Upload Frontend to S3') {
    steps {
        script {
            s3Upload(
                bucket: 'ewan-frontend-bucket',
                file: 'frontend/dist',
                path: '',
                profile: 'ewan-s3-profile',
                region: 'eu-west-2'
            )
        }
    }
}


        
}
}