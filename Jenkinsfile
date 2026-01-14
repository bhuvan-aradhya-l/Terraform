pipeline {
    agent any

    stages {

        stage('Checkout Code') {
            steps {
                git branch: 'master',
                    url: 'https://github.com/bhuvan-aradhya-l/Terraform.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh '''
                  terraform init -input=false
                '''
            }
        }

        stage('Terraform Validate') {
            steps {
                sh '''
                  terraform validate
                '''
            }
        }

        stage('Terraform Plan') {
            steps {
                sh '''
                  terraform plan -out=tfplan
                '''
            }
        }

        stage('Terraform Apply') {
            steps {
                sh '''
                  terraform apply --auto-approve
                '''
            }
        }
    }

    post {
        success {
            echo "Terraform pipeline executed successfully"
        }
        failure {
            echo "Terraform pipeline failed"
        }
    }
}
