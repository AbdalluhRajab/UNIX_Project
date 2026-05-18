pipeline {
    agent any

    // Jenkins checks GitHub every 2 minutes for new commits.
    triggers {
        pollSCM('H/2 * * * *')
    }

    environment {
        GIT_REPO  = 'https://github.com/AbdalluhRajab/UNIX_Project.git'
        GIT_BRANCH = 'main'

        MYSQL_ROOT_PASSWORD = 'password'
        MYSQL_DATABASE      = 'recommendations_db'

        // Use a project name different from Jenkins's own compose project,
        // so the pipeline only ever touches the application containers.
        COMPOSE_PROJECT_NAME = 'unix-project'
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Pulling latest code from ${GIT_REPO} branch ${GIT_BRANCH}"
                sh 'bash scripts/pull.sh .'
            }
        }

        stage('Build') {
            steps {
                echo 'Building application Docker image...'
                sh 'docker compose -p unix-project build www'
            }
        }

        stage('Deploy') {
            steps {
                echo 'Recreating application containers (www, db, phpmyadmin only).'
                echo 'Jenkins container is intentionally excluded.'
                sh 'docker compose -p unix-project up -d --force-recreate www db phpmyadmin'
                sh 'sleep 10'
            }
        }

        stage('Smoke Test') {
            steps {
                echo 'Checking that the recommendation page is served correctly...'
                sh '''
                    body=$(curl -sf http://www/) || {
                        echo "Application is not responding"
                        exit 1
                    }
                    if echo "$body" | grep -q "Recommendation System"; then
                        echo "Application is serving the recommendation page"
                    else
                        echo "Got HTTP 200 but the page is not the recommendation app:"
                        echo "$body" | head -20
                        exit 1
                    fi
                '''
            }
        }
    }

    post {
        success {
            echo 'Pipeline finished successfully.'
            echo 'Application is available on http://192.168.1.31:8080'
        }
        failure {
            echo 'Pipeline failed. Check the logs above.'
        }
        always {
            echo 'Pipeline run complete.'
        }
    }
}
