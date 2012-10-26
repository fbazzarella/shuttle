Shuttle.setup do |s|

  # TODO: Setup Steps Description

  s.steps = [
    'shuttle:start',
    'shuttle:bundle',
    'db:migrate',
    'shuttle:spec',
    'shuttle:git:push'
  ]

end
