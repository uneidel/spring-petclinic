pipeline {
   agent any
 
   environment {
      dockerHome = tool 'dockerengine'
      mavenHome = tool 'mvn'
      PATH = "$dockerHome/bin:$mavenHome/bin:$PATH"
      regName = "uneidel.jfrog.io"
      imageName = "tompetty"
      repokey = "uneidel-docker-local"
   }
 
   stages{
 
      stage('Compile') {
         steps{
            sh "mvn clean compile"
         }
      }
 
      stage('Test') {
         steps{
            sh "mvn test"
         }
      }
 
      stage('Integration Test') {
         steps{
            sh "mvn failsafe:integration-test failsafe:verify"
         }
      }
 
      stage('Package') {
         steps{
            script{
               sh "mvn package -DskipTests"
            }
         }
      }

      stage('Build Docker Image') {
         steps{
            script{
            dockerImage = docker.build("${env.regName}/${repokey}/${env.imageName}:${env.BUILD_TAG}")
            }
         }
      }

       stage ('Push image to Artifactory') { 
        steps {
            rtDockerPush(
                serverId: "uneidel",
                host: "tcp://172.17.0.1:2375",
                image: "${env.regName}/${repokey}/${env.imageName}:${env.BUILD_TAG}",                
                targetRepo: 'uneidel-docker-local'
               
            )
        }
    }
   }
}