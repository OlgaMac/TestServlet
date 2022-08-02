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
       stage('Deployment') {
                 steps {
                    sh 'docker build -f Dockerfile -t testservlet:latest .'
                }
             }

        stage('Login') {
                  steps {
                     sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
                }
             }

        stage('Push') {

       			steps {
       				sh 'docker push testservlet:latest'
       			}
       		}
      }
        post {
            	always {
            		sh 'docker logout'
            	}
        }
    }

