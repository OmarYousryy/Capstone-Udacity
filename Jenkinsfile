pipeline {
    environment {
    registry = "mohammedx3/capstone-project"
    registryCredential = 'docker-creds'
    dockerImage = ''
    eksClusterName = 'Capstone-cluster'
    eksRegion = 'eu-west-1'
}
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
            steps{    
                script {
                docker.withRegistry( '', registryCredential ) {
                    dockerImage.push()
                }
                }
            }

            }    

          stage('Deployment') {
             steps {
             withAWS(credentials: 'aws-creds', region: 'eu-west1') {
                    sh 'aws eks --region=${eksRegion} update-kubeconfig --name ${eksClusterName}'
                    sh 'kubectl apply -f k8s/k8s.yml'
                    sh 'kubectl get pods'
                }
      }
    }  

}
}