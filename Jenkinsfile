pipeline {
    agent none

    parameters {
        string(name:'GIT_TAG', defaultValue:'', description:'docker image tag')
    }

    environment {
        git_user = 'aeternus'
        git_email = 'aeternus@aliyun.com'
        image_name = 'jnlp-slave'
    }

    stages {
        stage('Build') {
            agent { dockerfile true }

            steps {
                sh 'echo "SUCESSE!"'
            }
        }

        stage('Tag') {
            agent { docker { image 'alpine:latest' } }

            environment {
                GITHUB_AUTH = credentials('GitHub-PAT')
            }

            when {
                beforeAgent true
                expression { params.GIT_TAG ==~ /^v[0-9.]+.*/ }
            }

            steps {
                sh 'apk add --no-cache git'

                sh 'git config --global user.name ${git_user}'
                sh 'git config --global user.email ${git_email}'
                sh 'git config --local credential.helper "!p() { echo username=${GITHUB_AUTH_USR}; echo password=${GITHUB_AUTH_PSW}; }; p"'

                sh 'env'
                //sh 'git tag ${params.GIT_TAG}'
                //sh 'git push origin ${params.GIT_TAG}'
            }
        }
    }
}
