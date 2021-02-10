pipeline {

  agent {
        dockerfile:true
  }
  
  stages{
  
  stage("build"){
  
    steps{
      echo 'building the application...'
        sh 'node --version'
    }
  
  }
  
  stage("test"){
  
    steps{
      echo 'testing the application...'
    }
  
  }
  
    stage("deploy"){
  
    steps{
     echo 'deploying the application...'
     sh 'echo myCustomEnvVar = $myCustomEnvVar'
    }
  
  }
  
  
  
  
  
  }
