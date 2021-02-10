pipeline {
    agent any
    
    environment {
    BITBUCKET_COMMON_CREDS = credentials('my-bitbucket-creds')
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
                sh 'make' 
                archiveArtifacts artifacts: '**/target/*.jar', fingerprint: true              
            }
        }
        stage('Test') {
            steps {
                sh 'make check || true' 
                junit '**/target/*.xml' 
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
                sh 'make publish'
                echo 'Building docker image'
                sh """
                 docker login ${REGISTRY_URI} -u ${BITBUCKET_COMMON_CREDS_USR} -p ${BITBUCKET_COMMON_CREDS_PSW}
                 docker build -t ${IMAGE_NAME}:${VERSION_PREFIX}${BUILD_NUMBER} ${WORKSPACE} -f Dockerfile
                 docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${REGISTRY_URI}/${REGISTRY_NAME}/${IMAGE_NAME}:${GIT_BRANCH}-${GIT_COMMIT}
                 docker push ${REGISTRY_URI}/${REGISTRY_NAME}/${IMAGE_NAME}:${GIT_BRANCH}-${GIT_COMMIT}
                """
            }
        }
    }
}
