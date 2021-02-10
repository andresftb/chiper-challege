pipeline {
    agent {
        docker {
            image 'node:12-alpine'
            args '-p 3000:3000' 
        }
    
    environment {
    REGISTRY_URI = registry.example.com
    REGISTRY_NAME = My_repository
    IMAGE_NAME = test
    VERSION_PREFIX = 1.0
    BUILD_NUMBER = 1.0
    WORKSPACE = development
    GIT_BRANCH = dev
    GIT_COMMIT = 1
    }

    stages {
        stage('Build') {
            steps { 
                sh 'npm install'v
                sh 'npm run build'
            }
        }
        stage('Test') {
            steps {
                sh 'npm run test'
                echo 'Testing my app'
            }
        }
        stage('Deploy') {
            when {
              expression {
                currentBuild.result == null || currentBuild.result == 'SUCCESS' 
              }
            }
            steps {
                
                withCredentials([usernamePassword(credentialsId: 'my_docker_credentials', passwordVariable: 'password', usernameVariable: 'user')]) {
                    sh """
                    docker login ${REGISTRY_URI} -u ${user} -p ${password}
                    """
                }
                echo 'Building docker image'
                sh """
                 docker build -t ${IMAGE_NAME}:${VERSION_PREFIX}${BUILD_NUMBER} ${WORKSPACE} -f Dockerfile
                 docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${REGISTRY_URI}/${REGISTRY_NAME}/${IMAGE_NAME}:${GIT_BRANCH}-${GIT_COMMIT}
                 docker push ${REGISTRY_URI}/${REGISTRY_NAME}/${IMAGE_NAME}:${GIT_BRANCH}-${GIT_COMMIT}
                """
            }
        }
    }
    post {
        failure {
            mail to: andresftbz88@gmail.com, subject: 'The Pipeline failed'
        }
    }
}
