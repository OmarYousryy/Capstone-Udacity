pipeline {
  agent any
  stages {
    stage('Lint HTML & Dockerfile') {
      steps {
        sh 'tidy -q -e *.html'
        echo 'Linting HTML'
        sh '/bin/hadolint Dockerfile'
        echo 'Linting Dockerfile'
      }
    }

    stage('Building image') {
      steps {
        script {
          dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }

      }
    }

    stage('Upload Image') {
      steps {
        script {
          docker.withRegistry( '', registryCredential ) {
            dockerImage.push()
          }
        }

      }
    }

    stage('Deployment') {
      steps {
        withAWS(credentials: 'omarc', region: 'us-west-2') {
          sh 'aws eks --region us-west-2 update-kubeconfig --name Capstone-cluster'
          sh 'kubectl config use-context arn:aws:eks:us-west-2:212930620470:cluster/Capstone-cluster'
          sh 'kubectl apply -f k8s/k8s.yml'
          sh 'kubectl get nodes'
          sh 'kubectl get pods'
        }

      }
    }

  }
  environment {
    registryCredential = 'Docker-Credentials'
    dockerImage = 'omary/test'
    eksClusterName = 'Capstone-cluster'
    eksRegion = 'us-west-2'
    registry = 'omary/test'
  }
}