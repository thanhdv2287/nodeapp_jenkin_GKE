
pipeline {

  environment {
    dockerimagename = "mrsudo/nodeapp"
    dockerImage = ""
    PROJECT_ID = 'thanhdv-lap'
    CLUSTER_NAME = 'cluster-1'
    LOCATION = 'us-central1-b'
    CREDENTIALS_ID = 'thanhdv-lap'
  }

  agent any

  stages {

    stage('Checkout Source') {
      steps {
        echo "Already checkout Source"
      }
    }

    stage('Build image') {
      steps{
        script {
          dockerImage = docker.build dockerimagename
        }
      }
    }

    stage('Pushing Image') {
      environment {
               registryCredential = 'dockerhublogin'
           }
      steps{
        script {
          docker.withRegistry( 'https://registry.hub.docker.com', registryCredential ) {
            dockerImage.push("latest")
            dockerImage.push("${env.BUILD_ID}")
          }
        }
      }
    }

    stage('Deploying App to Kubernetes') {
      steps{
        sh "sed -i 's/nodeapp:latest/:${env.BUILD_ID}/g' deploymentservice.yml"
                step([$class: 'KubernetesEngineBuilder', projectId: env.PROJECT_ID, clusterName: env.CLUSTER_NAME, location: env.LOCATION, manifestPattern: 'deploymentservice.yml', credentialsId: env.CREDENTIALS_ID, verifyDeployments: false])
            }
    }

  }

}
