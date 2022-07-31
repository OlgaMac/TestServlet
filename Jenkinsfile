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
        stage('Test') {
            steps {
                echo 'testing stage'
            }
        }
        stage('Deploy') {
            steps {
            echo 'deploy stage'
                script{
                   deploy adapters: [tomcat9(credentialsId: 'jenkins-tomcat-war-deploy', path: '',
                    url: 'http://178.210.92.7:8085')], contextPath: '/pipeline',
                    onFailure: false, war: 'webapp/target/*.war'
                }
            }
        }
    }
}
