pipeline {
    agent any


    stages {


        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                checkout([$class: 'GitSCM'
                            , branches: [[name: "main"]]
                            , doGenerateSubmoduleConfigurations: false
                            , extensions: [[$class: 'SubmoduleOption'
                                            , disableSubmodules: false
                                            , parentCredentials: false
                                            , recursiveSubmodules: false
                                            , reference: ''
                                            , trackingSubmodules: false]]
                            , submoduleCfg: []
                            , userRemoteConfigs: [[url: 'https://github.com/KorayKoygunTDL/ui-automation.git']]]
                        )


            }
        }
        stage('Build') {
            steps {
                script {
                     docker.build("koraykoyguntdl/mvn_tests:version-$BUILD_NUMBER",".")
                }
            }
        }
        stage('Deploy') {
            steps {
                script {
                sh "docker-compose up -d"
                }
            }
        }
        stage ('Test') {

            steps {
                script {
                        sh 'docker run -i --network=docker-base_test-automation-setup koraykoyguntdl/mvn_tests:version-$BUILD_NUMBER mvn clean test -DgridURL=selenium-hub:4444'
                }
            }
        }
        stage('Is test passed'){
            steps{
                input("Do you want process to the production stage?")
            }
        }
        stage("Production transition"){
            steps{
                script{
                    sh 'echo PRODUCTION TRANSITIONED'
                }
            }
        }
        stage('Build-Production') {
            steps {
                script {
                     docker.build("koraykoyguntdl/mvn_tests:version-$BUILD_NUMBER",".")
                }
            }
        }
        stage('Deploy-Production') {
            steps {
                script {
                sh "docker-compose up -d"
                }
            }
        }
        stage ('Test-Production') {

            steps {
                script {
                        sh 'docker run -i --network=docker-base_test-automation-setup koraykoyguntdl/mvn_tests:version-$BUILD_NUMBER mvn clean test -DgridURL=selenium-hub:4444'
                }
            }
        }
    }
    post {
        success {
            echo 'Succeeded!'
        }
        unstable {
            echo 'Unstable'
        }
        failure {
            echo 'Failed'
        }
        changed {
            echo 'There are some changes'
        }
    }
}