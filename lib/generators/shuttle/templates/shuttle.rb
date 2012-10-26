Shuttle.setup do |s|

  # TODO: Setup Steps Description

  s.steps = [
    'shuttle:start',
    'shuttle:bundle',
    'db:migrate',
    'shuttle:spec',
    'shuttle:git:push'
  ]

  # TODO: Setup Stages Description

  # s.stages = {
  #   staging:    'your@server.com:staging-repository.git',
  #   production: 'your@server.com:production-repository.git'
  # }

end
