pipeline {
    agent any

    triggers {
        pollSCM('H/2 * * * *')
    }

    environment {
        GIT_REPO = 'https://github.com/AbdalluhRajab/UNIX_Project.git'
        GIT_BRANCH = 'main'

        MYSQL_ROOT_PASSWORD = 'password'
        MYSQL_DATABASE = 'recommendations_db'

        COMPOSE_PROJECT_NAME = 'recommendation-app'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Pulling latest code from ${GIT_REPO} branch ${GIT_BRANCH}"
                git branch: "${GIT_BRANCH}", url: "${GIT_REPO}"
            }
        }

        stage('Build') {
            steps {
                echo 'Building Docker images'
                sh 'docker compose -p recommendation-app build'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Stopping old containers if they exist'
                sh 'docker compose -p recommendation-app down || true'

                echo 'Starting updated containers'
                sh 'docker compose -p recommendation-app up -d --build --force-recreate'

                echo 'Waiting for containers to start'
                sh 'sleep 15'
            }
        }

        stage('Smoke Test') {
            steps {
                echo 'Checking if the application is running on port 8000'
                sh '''
                    if curl -sf http://host.docker.internal:8000/ > /dev/null; then
                        echo "Application is running successfully"
                    else
                        echo "Application is not responding"
                        exit 1
                    fi
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline finished successfully'
            echo 'Application is available on http://localhost:8000'
        }

        failure {
            echo 'Pipeline failed. Check the logs above'
        }

        always {
            echo 'Pipeline run complete'
        }
    }
}