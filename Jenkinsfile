node {
  checkout scm

    def img

    stage 'Docker' {
      img = dockers.build('builder', '.')
    }

  stage 'Test' {
    img.inside {
      sh('rake')
    }
  }
}
