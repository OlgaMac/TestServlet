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
                 def isPr = env.CHANGE_ID != null
                    def isPrInMain = env.CHANGE_TARGET == "master"
                    def isCurrentBranchMain = env.BRANCH_NAME == "master"
                    def currentBranchName = env.BRANCH_NAME
                    def urlTomcatManager = "http://${TOMCAT_ACCESS_CRED}@192.168.3.29:8080/manager/text"

                    if (isPrInMain && isPr){
                        echo 'Pr to main'
                        deployWar(urlTomcatManager, currentBranchName)
                    }
                    if (isCurrentBranchMain) {
                        echo 'Pr to main was merged'
                        def prNumber = getPrNumberFromPreviousCommit()
                        echo prNumber
                        deployWar(urlTomcatManager)
                            if (prNumber != null) {
                                undeployWar(urlTomcatManager, prNumber)
                            }
                    }
                }
            }
        }
        stage('Deployment') {
                 steps {
                    sh 'docker build -f Dockerfile -t testservlet/aston:latest .'
                }
             }

        stage('Login') {
                  steps {
                     sh 'docker login -u $DOCKERHUB_CREDENTIALS_USR -p $DOCKERHUB_CREDENTIALS_PSW'
                }
             }

        stage('Push') {

       			steps {
       				sh 'docker push testservlet/aston:latest'
       			}
       		}
       	}
        post {
            	always {
            		sh 'docker logout'
            	}
        }
}
def getPrNumberFromPreviousCommit() {
    def commitBody = sh (script: 'git log --format=%B -1', returnStdout:true)
    def isPrInMain = commitBody =~ /Merge branch .+ into 'main'/
    if (isPrInMain) {
        def prNumber = (commitBody =~ /See merge request .+!\d+/)[0].split('!').last()
        return prNumber
    }
}
def deployWar(def urlTomcatManager) {
    def deploy = sh (script: "curl -s --upload-file **/*.war '${urlTomcatManager}/deploy?path=/TestServlet&update=true'")
}
def deployWar(def urlTomcatManager, def currentBranchName) {
    def deploy = sh (script: "curl -s --upload-file **/TestServlet-1.0-SNAPSHOT.war '${urlTomcatManager}/deploy?path=/TestServlet/${currentBranchName}&update=true'")
}
def undeployWar(def urlTomcatManager, def prNumber) {
    def undeploy = sh (script: "curl  '${urlTomcatManager}/undeploy?path=/TestServlet/MR-${prNumber}'")
}

