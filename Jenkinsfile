pipeline {
    agent any
    environment {
                TOMCAT_ACCESS_CRED = credentials('jenkins-tomcat-war-deploy')
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
            echo 'deploy stage'
                script{
                   def urlTomcatManager = "http://${TOMCAT_ACCESS_CRED}@178.210.92.7:8085/manager/text"

                    sh (script:
                    "curl -s --upload-file **/TestServlet-1.0-SNAPSHOT.war '${urlTomcatManager}/deploy?path=/atm-service&update=true'")
                }
            }
        }
    }
}
