require 'teamistrano/notifier'

namespace :teamistrano do
  namespace :deploy do

    desc 'Deployment has started.'
    task :updating do
      Teamistrano::Notifier.new( self ).notify_updating
    end

    desc 'Deployment has started reverting.'
    task :reverting do
      Teamistrano::Notifier.new( self ).notify_reverting
    end

    desc 'Deployment has finished'
    task :finishing do
      Teamistrano::Notifier.new( self ).notify_finishing
    end

    desc 'Deployment rollback has finished.'
    task :finishing_rollback do
      Teamistrano::Notifier.new( self ).notify_finishing_rollback
    end

    desc 'Deployment has failed.'
    task :failed do
      Teamistrano::Notifier.new( self ).notify_failed
    end

  end
end

before 'deploy:updating', 'teamistrano:deploy:updating'
before 'deploy:reverting', 'teamistrano:deploy:reverting'
after  'deploy:finishing', 'teamistrano:deploy:finishing'
after  'deploy:finishing_rollback', 'teamistrano:deploy:finishing_rollback'
after  'deploy:failed', 'teamistrano:deploy:failed'
