# 
# Helper class: used to access settings/configuration.
# 
module Teamistrano
  class Settings
    
    def initialize( env )
      @env = env
      @config = @env.fetch( :teamistrano, {} )
    end

    # Get the URL for the webhook call.
    def webhook_url
      return @config[ :webhook ]
    end

    # Should we use curl to post the message to teams?
    def use_curl?
      o = @config[ :curl ]
      if o
        return true
      else
        return false
      end
    end

    # Get the local user name.
    def get_local_user
      return ENV['USER'] || ENV['USERNAME']
    end
    
    # Get the name of the deployer.
    def deployer
      return @env.fetch( :local_user, get_local_user)
    end
    
    # Get the branch being deployed.
    def branch
      @env.fetch( :branch, "N/A" )
    end
    
    # Get the name of the application being deployed.
    def application
      @env.fetch( :application, "N/A" )
    end
    
    # Get the stage of deployment (TEST, PROD).
    def stage
      @env.fetch( :stage, "N/A" )
    end
    
    # Show the settings.
    # This is a debugging function only.
    def show
      puts "------------------- settings -------------------"
      puts "Application: #{application}"
      puts "Branch: #{branch}"
      puts "Stage: #{stage}"
      puts "Deployer: #{deployer}"
      puts "Local User: #{get_local_user}"
      puts "URL: #{webhook_url}"
      puts "------------------------------------------------"
    end

  end
end
