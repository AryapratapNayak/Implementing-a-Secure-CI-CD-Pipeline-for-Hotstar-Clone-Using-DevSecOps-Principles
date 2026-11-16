
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

        stage('SonarQube Analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    script {
                        def scannerHome = tool 'SonarScanner'
                        sh """
                            "${scannerHome}/bin/sonar-scanner" \
                            -Dsonar.projectKey=Hotstar-DevSecOps \
                            -Dsonar.projectName=Hotstar-DevSecOps \
                            -Dsonar.sources=src \
                            -Dsonar.sourceEncoding=UTF-8 \
                            -Dsonar.scanner.skipNodeProvisioning=true
                        """
                    }
                }
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
            echo 'SUCCESS: React build, SonarQube analysis and Docker image creation completed.'
        }
        failure {
            echo 'FAILED: Check the stage logs above.'
        }
    }
}
