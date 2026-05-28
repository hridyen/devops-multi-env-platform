pipeline {
    agent any

    environment {
        IMAGE_NAME = "devops-flask-app"
        ALLOWED_BRANCHES = "develop,main"
    }

    triggers {
        githubPush()
    }

    stages {

        stage('Detect Branch') {
            steps {
                script {

                    def branch = env.GIT_BRANCH ?: env.BRANCH_NAME

                    branch = branch.replace("origin/", "")

                    env.CURRENT_BRANCH = branch

                    echo "Current Branch: ${env.CURRENT_BRANCH}"
                }
            }
        }

        stage('Validate Branch') {
            steps {
                script {

                    def allowed = ALLOWED_BRANCHES.split(",")

                    if (!allowed.contains(env.CURRENT_BRANCH)) {
                        error("Branch not allowed for deployment")
                    }
                }
            }
        }

        stage('Checkout Code') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {

                sh """
                docker build \
                -t ${IMAGE_NAME}:${CURRENT_BRANCH} \
                ./app
                """
            }
        }

        stage('Stop Old Container') {
            steps {

                sh """
                docker rm -f ${IMAGE_NAME}-${CURRENT_BRANCH} || true
                """
            }
        }

        stage('Run Container') {
            steps {
                script {

                    def port = CURRENT_BRANCH == "develop" ? "3001" : "3002"

                    sh """
                    docker run -d \
                    --name ${IMAGE_NAME}-${CURRENT_BRANCH} \
                    -p ${port}:5000 \
                    ${IMAGE_NAME}:${CURRENT_BRANCH}
                    """
                }
            }
        }

        stage('Show Running Containers') {
            steps {

                sh "docker ps"

            }
        }
    }

    post {

        success {
            echo "Deployment Successful 🚀"
        }

        failure {
            echo "Pipeline Failed ❌"
        }
    }
}