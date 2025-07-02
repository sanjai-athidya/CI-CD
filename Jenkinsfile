pipeline {
    agent any

    environment {
        IMAGE_NAME = "my-website-image"
        CONTAINER_PORT = "82"
        HOST_PORT = "82"
        REPO_URL = "https://github.com/hshar/website.git"
    }

    stages {
        stage('Clone Website Code') {
            steps {
                dir('website') {
                    git branch: "master", url: "${REPO_URL}"

                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build("${IMAGE_NAME}:${env.BRANCH_NAME}", ".")
                }
            }
        }

        stage('Run Container') {
            when {
                branch 'master'
            }
            steps {
                script {
                    sh '''
                        docker rm -f website-container || true
                        docker run -d --name website-container \
                        -v $PWD/website:/var/www/html \
                        -p ${HOST_PORT}:${CONTAINER_PORT} \
                        ${IMAGE_NAME}:${BRANCH_NAME}
                    '''
                }
            }
        }
    }
}
