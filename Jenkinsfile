

pipeline {
    agent any

    triggers {
        pollSCM('H/2 * * * *')
    }

    environment {
        GIT_REPO = 'https://github.com/AbdalluhRajab/UNIX_Project.git'
        GIT_BRANCH = 'main'
    }

    stages {

        stage('Checkout') {
            steps {
                echo "Pulling latest code from ${GIT_REPO} (branch: ${GIT_BRANCH})..."
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker images...'
                sh 'docker compose build'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Stopping any existing containers and starting fresh...'
                sh 'docker compose up -d --force-recreate www db'
                echo 'Waiting a few seconds for the app to be ready...'
                sh 'sleep 5'
            }
        }

        stage('Smoke Test') {
            steps {
                echo 'Verifying the app responds on port 8000...'
                sh '''
                    if curl -sf http://localhost:8000/ > /dev/null; then
                        echo "App is UP and responding"
                    else
                        echo "App is DOWN"
                        exit 1
                    fi
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline finished successfully. App is live at http://<server-ip>:8000'
        }
        failure {
            echo 'Pipeline failed. Check the logs above.'
        }
        always {
            echo 'Pipeline run complete.'
        }
    }
}
