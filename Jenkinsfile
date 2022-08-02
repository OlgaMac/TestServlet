pipeline {
    agent any
    environment {
                TOMCAT_ACCESS_CRED = credentials('jenkins-tomcat-war-deploy')
                DOCKERHUB_CREDENTIALS=credentials('docker-registry-credentials')
            }
    tools {
        maven 'maven'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn package'
                }
            }
        stage('Test') {
            steps {
                echo 'testing stage'
            }
        }
        stage('Deploy') {
            steps {
                script{
                   sh (script: "curl -s --upload-file **/*.war '${TOMCAT_ACCESS_CRED}@192.168.3.29:8085/manager/text/deploy?path=/TestServlet&update=true'")
                }
            }
        }
     }
 }


