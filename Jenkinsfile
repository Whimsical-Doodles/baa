node {
  stage 'Checkout'
  git 'https://whimsicaldoodles:gGxYqfqbZpvi3dsSlHgUtCG7la7CLSDM@bitbucket.org/whimsicaldoodles/baa.git'

  stage 'Docker'
  def img = docker.build('builder', '.')

  stage 'Test'
  img.run('builder')
}
