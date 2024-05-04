pipeline {
    agent any

    environment {
        AWS_DEFAULT_REGION = 'us-east-1'  
        ECR_REPO_NAME = 'my-repository'          
        LAMBDA_FUNCTION_NAME = 'my_lambda_function'
    }

    stages {
        stage('Build Docker Image') {
            steps {
                script {
                    docker.build("my-docker-image:latest", ".")
                }
            }
        }

        stage('Push Docker Image to ECR') {
            steps {
                script {
                    withCredentials([[
                        $class: 'AmazonWebServicesCredentialsBinding',
                        accessKeyVariable: '********************',
                        credentialsId: 'your-aws-credentials-id',
                        secretKeyVariable: '**************']]) {
                        docker.withRegistry('https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com', 'ecr:us-east-1') {
                            docker.image("my-docker-image:latest").push("${ECR_REPO_NAME}:latest")
                        }
                    }
                }
            }
        }

        stage('Create Lambda Function') {
            steps {
                script {
                    sh "aws lambda create-function --function-name ${LAMBDA_FUNCTION_NAME} --runtime python3.8 --role arn:aws:iam::${AWS_ACCOUNT_ID}:role/lambda-role --handler app.lambda_handler --code ImageUri=${ECR_REPO_NAME}:latest"
                }
            }
        }

        stage('Test Lambda Function') {
            steps {
                script {
                    sh "python lambda_test.py"
                }
            }
        }
    }
}
