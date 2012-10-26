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

  task spec: 'db:test:prepare' do
    sh 'rspec spec'
  end

  task start: ['git:check', 'log:clear', 'tmp:clear', 'git:pull']

  def p80(message)
    puts '-' * 80
    puts message if message
    yield if block_given?
  end
end

desc 'Launch the code to the space!'
task :shuttle, :stage do |t, args|
  Rake::Task[:environment].invoke

  if Shuttle.steps.blank?
    require 'colored'

    puts %{
      You should define Shuttle Steps in 'config/initializers/shuttle.rb'.

      Or run 'rails g shuttle:install' to create this file with default steps.
    }.yellow

    exit
  end

  Shuttle.steps.each do |step|
    p80("Executing #{step}...") do
      RAILS_ENV = ENV['RAILS_ENV'] || 'development'
      Rake::Task[step].invoke
    end
  end

  repository = Shuttle.stages[args[:stage].try(:to_sym)]

  if repository.present?
    p80("Executing deploy to #{args[:stage].to_s}...") do
      sh "git push #{repository} HEAD:master -f"
    end
  end
end
