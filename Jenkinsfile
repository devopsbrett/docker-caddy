#!groovy​
properties([[$class: 'jenkins.model.BuildDiscarderProperty', strategy: [$class              : 'LogRotator',
                                                                        numToKeepStr        : '4',
                                                                        artifactNumToKeepStr: '4']]])

node {
  checkout scm
  def REPO = 'brettm/caddy-test'
  def GIT_COMMIT = sh(returnStdout: true, script: 'git rev-parse --short HEAD').trim()
  def DEPLOY_TAG = "$REPO:$GIT_COMMIT"
  def FAST_PATH = ''

  stage('Fastpath') {
      withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: 'dockercreds',
        usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD']]) {
          sh("docker run --rm -v \$(pwd):/data -e DOCKER_USERNAME=$DOCKER_USERNAME -e DOCKER_PASSWORD=$DOCKER_PASSWORD brettm/fastpath HEAD $REPO")
        }
  }

  stage('test') {
      withDockerRegistry([credentialsId: 'dockercreds']) {
          sh("env")
          sh("ls -al")
      }
  }


//   stage('Build') {
//       docker.build(DEPLOY_TAG)
//   }

//   stage('deploy to dockerhub') {
//       withDockerRegistry([credentialsId: 'dockercreds']) {
//           docker.image(DEPLOY_TAG).push()
//           if(env.BRANCH_NAME == 'develop') {
//               docker.image(DEPLOY_TAG).push('latest-snapshot')
//           }
//           if(env.BRANCH_NAME == 'master') {
//               docker.image(DEPLOY_TAG).push('latest')
//           }
//       }
//   }

//   stage('env') {
//     sh("env")
//   }

}