node {
  stage 'Docker'
  def img = docker.build('ruby-runner', '.')

  stage 'Test'
  img.run('rake')
}
