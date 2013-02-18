require 'colored'

namespace :shuttle do
  namespace :git do
    task :check do
      out = `git status`

      if out.include?('Untracked files:') || out.include?('unmerged:') || out.include?('modified:')
        puts %{
  You have some files to be commit. Please check it with 'git status'.
        }.red

        exit
      end
    end

    task :pull do
      sh 'git pull --rebase'
    end

    task :push do
      sh 'git push'
    end
  end

  task :bundle do
    sh 'bundle install --quiet'
  end

  task spec: 'db:test:prepare' do
    sh 'rspec spec'
  end
end

desc 'Launch the code to space!'
task :shuttle, [:stages] => :environment do |t, args|
  if Shuttle.steps.blank?
    puts %{
  You should define Shuttle Steps and Stages in 'config/shuttle.yml'.
  Or run 'rails g shuttle:install' to create this file with default steps and stages.
    }.yellow

    exit
  end

  def p80(message)
    puts '-' * 80
    puts message if message
    yield if block_given?
  end

  Shuttle.steps.each do |step|
    p80("Executing #{step}...") do
      Rake::Task[step].invoke
    end
  end

  if args[:stages].present?
    args[:stages].split(':').each do |stage|
      if repository = Shuttle.stages.try(:[], stage)
        p80("Executing deploy to #{stage}...") do
          sh "git push #{repository} HEAD:master -f"
        end
      end
    end
  end
end
