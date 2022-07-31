pipeline {
    agent any
    tools {
        maven 'maven'
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