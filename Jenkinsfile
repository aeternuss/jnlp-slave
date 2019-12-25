pipeline {
    agent { none }

    parameters {
        string(name:'GIT_TAG', defaultValue:'NULL', description:'docker image tag')
    }

    environment {
        git_user = 'aeternus'
        git_email = 'aeternus@aliyun.com'
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
                GITHUB_AUTH = credentials('5c078334-f2e8-44c0-acb3-a8d6f03cc61b')
            }

            when {
                not { equals expected:'NULL', actual:params.GIT_TAG }
            }

            steps {
                sh 'apk add --no-cache git'

                sh 'git config --global user.name=${git_user}'
                sh 'git config --global user.email=${git_email}'
                sh 'git config --local credential.helper "!p() { echo username=$GITHUB_AUTH_USR; echo password=$GITHUB_AUTH_PSW; }; p"'

                sh 'git tag ${params.GIT_TAG}'
                sh 'git push origin ${params.GIT_TAG}'
            }
        }
    }
}
