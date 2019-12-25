pipeline {
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
            environment {
                GITHUB_AUTH = credentials('github-auth')
            }

            when {
                not { equals expected:'NULL', actual:params.GIT_TAG }
            }

            agent { docker { image 'alpine:latest' } }

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
