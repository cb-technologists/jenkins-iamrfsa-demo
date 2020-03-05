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
        container("aws-cli") {
          sh "sed -i 's/BUILD_ID/${env.BUILD_ID}/' index.html"
          sh "aws s3 cp index.html s3://${params.S3_BUCKET_NAME} --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers"
        }
      }
    }
  }
}