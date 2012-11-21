Shuttle.setup do |s|
  s.steps = [
    'shuttle:git:check',
    'shuttle:git:pull',
    'shuttle:bundle',
    'db:migrate',
    'shuttle:spec',
    'shuttle:git:push',
    # 'log:clear',
    # 'tmp:clear',
  ]

  # s.stages = {
  #   staging:    'your@server.com:staging-repository.git',
  #   production: 'your@server.com:production-repository.git'
  # }
end
