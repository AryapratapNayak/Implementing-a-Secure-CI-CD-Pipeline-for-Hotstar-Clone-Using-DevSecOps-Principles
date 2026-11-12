pipeline {
    agent {
        label 'hotstar-build-agent-2'
    }

    options {
        timestamps()
        disableConcurrentBuilds()
    }

    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Verify Tools') {
            steps {
                sh 'node --version'
                sh 'npm --version'
                sh 'docker version'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh 'npm ci --no-audit --no-fund'
            }
        }

        stage('Build React App') {
            steps {
                sh 'CI=true npm run build'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t hotstar-clone:${BUILD_NUMBER} -t hotstar-clone:latest .'
            }
        }
    }

    post {
        success {
            echo 'SUCCESS: React build and Docker image creation completed.'
        }
        failure {
            echo 'FAILED: Check the stage logs above.'
        }
    }
}
