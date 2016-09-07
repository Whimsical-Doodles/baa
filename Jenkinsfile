node('docker-build') {
  checkout scm

  stage 'Docker'
  def img = docker.build('builder', '.')

  stage 'Test'
  img.inside {
    sh('rake')
  }
}
