node {
  stage 'Docker'
  def img = docker.build('ruby:latest', '.')

  stage 'Test'
  img.run('cd /app/ && rake')
}
