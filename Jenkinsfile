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
                    url: 'http://server.my.ru:8085')], contextPath: '/pipeline',
                    onFailure: false, war: 'webapp/target/*.war'
                }
            }
        }
    }
}
