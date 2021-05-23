pipeline{
    agent{
        label 'agentx'
    }
     tools {
        maven 'maven1' 
    }
    options {
      buildDiscarder logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '5', numToKeepStr: '5')
      timeout(5)

    } 


    stages{
        stage('checkout'){
            steps{
            checkout scm
            }
        }
        stage('build'){
            steps{
                sh 'mvn --version'
                sh 'mvn clean install -Dskiptests'
            }
        }
        stage('Test'){
            steps{
            sh "mvn test"
            junit allowEmptyResults: true, testResults: 'target/surefire-reports/*xml'
            }
        
        }
       stage('Deploy'){
           steps{
               sshagent(['maven-cd-key']) {
                sh "scp  -o StrictHostKeyChecking=no target/my-app-1.0-SNAPSHOT ubuntu@54.160.246.98:/home/ubuntu"
            }

           }
       }
        
    }
    post{
        always{
            deleteDir()
        }
        failure{

            echo "send the mail to the testers or may be dev"
        }
        success{
            echo "build is successful"
        }

    }
}
