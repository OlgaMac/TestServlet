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
                   def urlTomcatManager = "http://${TOMCAT_ACCESS_CRED}@192.168.3.29/manager/text"

                    sh (script:
                    "curl -s --upload-file **/TestServlet-1.0-SNAPSHOT.war '${urlTomcatManager}/deploy?path=/TestServlet&update=true'")
                }
            }
        }
    }
}
