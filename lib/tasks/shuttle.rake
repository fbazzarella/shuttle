namespace :shuttle do
  namespace :git do
    task :check do
      out = `git status`

      if out.include?('Untracked files:') || out.include?('unmerged:') || out.include?('modified:')
        puts out
        exit
      end
    end

    task :pull do
      sh "git pull --rebase"
    end

    task :push do
      sh "git push"
    end
  end

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
  if Shuttle.steps.nil?
    require 'colored'

    puts %{
      You should define Shuttle Steps!

      Just run 'rails g shuttle:install' to define default steps at 'config/shuttle.yml'.
    }.yellow
    exit
  end

  Shuttle.steps.values.each do |step|
    p80("Executing #{step}...") do
      RAILS_ENV = ENV['RAILS_ENV'] || 'development'
      Rake::Task[step].invoke
    end
  end
end
