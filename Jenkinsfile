node {
  checkout scm

  stage 'Docker'

    def img = dockers.build('builder', '.')

  stage 'Test'

    img.inside {
      sh('rake')
    }
}
