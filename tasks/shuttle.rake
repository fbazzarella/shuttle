namespace :shuttle do
  namespace :git do
    desc 'Check for nothing to be commit'
    task :check do
      out = `git status`

      if out.include?('Untracked files:') || out.include?('unmerged:') || out.include?('modified:')
        puts out
        exit
      end
    end

    desc 'Update files from repository'
    task :pull do
      sh "git pull --rebase"
    end

    desc 'Send files to repository'
    task :push do
      sh "git push"
    end
  end

  desc 'Run bundle'
  task :bundle do
    sh 'bundle install --quiet'
  end

  task start: ['git:check', 'log:clear', 'tmp:clear', 'git:pull']

  def p80(message)
    puts '-' * 80
    puts message if message
    yield if block_given?
  end
end

desc 'Integrate the project code'
task :shuttle do
  if !defined?(SHUTTLE_STEPS)
    require 'colored'

    puts %{
      You should define SHUTTLE_STEPS constant. We recommend that you define it on lib/tasks/shuttle.rake.

      A sample content look like this:

        SHUTTLE_STEPS = %w(
          shuttle:start
          shuttle:bundle
          db:migrate
          spec
          shuttle:git:push
        )
    }.yellow
    exit
  end

  SHUTTLE_STEPS.each do |step|
    p80("Executing #{step}...") do
      RAILS_ENV = ENV['RAILS_ENV'] || 'development'
      Rake::Task[step].invoke
    end
  end
end
