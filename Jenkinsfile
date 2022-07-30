pipeline {
    agent any
    environment {
            TOMCAT_ACCESS_CRED = credentials('jenkins-tomcat-war-deploy')
        }
    tools {
        maven 'maven-3.8.4'
    }
    stages {
        stage('Build') {
            steps {
                sh 'mvn package'
                }
            }
        stage('Checkstyle') {
            steps {
                recordIssues(healthy: 1,
                        tools: [checkStyle(reportEncoding: 'UTF-8')])
                sh "mvn checkstyle:check"
            }
        }
        stage('Test') {
            steps {
                echo 'testing stage'
            }
        }
    }
}
