pipeline {
    agent any

    environment {
        BRANCH_NAME = "master"
        IMAGE_NAME = "my-website-image"
        REPO_URL = "https://github.com/sanjai-athidya/CI-CD.git"
        HOST_PORT = "82"
        CONTAINER_PORT = "82"
    }

    stages {
        stage('Clone Website Code') {
            steps {
                dir('website') {
                    git branch: "${BRANCH_NAME}", url: "${REPO_URL}"
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${BRANCH_NAME}", "website")
                }
            }
        }

        stage('Run Container') {
            when {
                branch 'master'
            }
            steps {
                script {
                    bat """
                    docker rm -f website-container || exit 0
                    docker run -d --name website-container ^
                    -p ${HOST_PORT}:${CONTAINER_PORT} ^
                    ${IMAGE_NAME}:${BRANCH_NAME}
                    """
                }
            }
        }
    }
}
