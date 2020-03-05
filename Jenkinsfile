pipeline {
  agent {
    kubernetes {
      label "aws-cli"
      yamlFile "awsCli.yaml"
    }
  }
  parameters {
    string(name: 'S3_BUCKET_NAME')
  }
  stages {
    stage("Deploy") {
      steps {
        container("kubectl-helm-aws") {
          sh "aws s3 cp index.html s3://${params.S3_BUCKET_NAME}"
        }
      }
    }
  }
}