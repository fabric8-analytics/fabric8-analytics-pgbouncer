#!/usr/bin/env groovy

node('docker') {

    def image = docker.image('bayesian/coreapi-pgbouncer')

    stage('Checkout') {
        checkout scm
    }

    stage('Build') {
        dockerCleanup()
        docker.build(image.id, '--pull --no-cache .')
    }

    stage('Integraion Tests') {
        sh "docker tag ${image.id} docker-registry.usersys.redhat.com/${image.id}"
        ws {
            // skipped for the first run as we need to "bootstrap" the docker images first
            //git url: 'https://github.com/baytemp/common.git', branch: 'master', credentialsId: 'baytemp-ci-gh'
            //dir('integration-tests') {
            //    timeout(30) {
            //        sh './runtest.sh'
            //    }
            //}
        }
    }

    if (env.BRANCH_NAME == 'master') {
        stage('Push Images') {
            def commitId = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
            docker.withRegistry('https://docker-registry.usersys.redhat.com/') {
                image.push('latest')
                image.push(commitId)
            }
            docker.withRegistry('https://registry.devshift.net/') {
                //image.push('latest')
                //image.push(commitId)
            }
        }
    }
}

//if (env.BRANCH_NAME == 'master') {
//    node('oc') {
//        stage('Deploy - dev') {
//            sh 'oc --context=dev deploy bayesian-worker --latest'
//        }
//
//        stage('Deploy - rh-idev') {
//            sh 'oc --context=dev deploy bayesian-worker --latest'
//        }
//
//        stage('Deploy - dsaas') {
//            sh 'oc --context=dsaas deploy bayesian-worker --latest'
//        }
//    }
//}
