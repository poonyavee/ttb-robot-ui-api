pipeline {
    agent any

    stages {
        stage('Checkout Code From Git') {
            steps {
                git branch: 'main', url: 'https://github.com/poonyavee/ttb-robot-ui-api.git'
            }
        }
        
        stage('Install Dependencies') {
            steps {
                sh 'pip3 install -r requirements.txt'
            }
        }
        
        stage('Run Robot Framework Tests') {
            steps {
                sh 'robot tests'
            }
        }
        
        stage('Send Result To Jenkins') {
            steps {
                junit 'output.xml'
            }
        }
    }
    
    post {
        success {
            echo 'Robot Framework tests executed successfully!'
        }
        failure {
            echo 'Robot Framework tests execution failed.'
        }
    }
}