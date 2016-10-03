node {
  checkout scm

  def img

  stage('Docker') {
    img = docker.build('builder', '.')
  }

  stage('Test') {
    img.inside {
      sh('rake')
    }
  }
}
