require 'teamistrano/settings'
require 'net/http'
require 'uri'
require 'json'

load File.expand_path( "../tasks/teamistrano.rake", __FILE__ )

module Teamistrano
  class Notifier
    
    DEFAULT_COLOR = "0033CC"  # blue
    GREEN = "00CC66"
    RED = "CC0000"
    
    def initialize( env )
      @env = env
      @settings = Teamistrano::Settings.new( @env )
      @color = DEFAULT_COLOR
      @msg = ""
    end
    
        
    # Send notice that deployment started.
    def notify_updating
      @msg = "Deployment Started"
      post
    end

    # Send notice that deployment is reverting.
    def notify_reverting
      @msg = "Deployment Reverting"
      post
    end

    # Send notice that deployment finished.
    def notify_finishing
      @color = GREEN
      @msg = "Deployment Finished"
      post
    end

    # Send notice that deployment rollback finished.
    def notify_finishing_rollback
      @msg = "Deployment Rollback Finished"
      post
    end

    # Send notice that deployment failed.
    def notify_failed
      @color = RED
      @msg = "Deployment Failed"
      post
    end
    
    # Get the full message to be delieved.
    def get_msg
      return "#{@msg} for #{@settings.application}.  (#{@settings.stage})
        \n Branch: #{@settings.branch} 
        \n Deployed by: #{@settings.deployer}"
    end
    
    # Get the body of the POST message as JSON.
    def get_body
      return {
        'title' => "Deployment Notice",
        'text' => get_msg,
        'themeColor' => @color
      }.to_json
    end

    # Post to Teams.
    def post
      if @settings.use_curl?
        post_with_curl
      else
        post_with_ruby
      end
    end
    
    # Post to Teams.
    def post_with_ruby
      uri = URI.parse( @settings.webhook_url )
      request = Net::HTTP::Post.new( uri.path )
      request.content_type = 'application/json'
      request.body = get_body
      n = Net::HTTP.new( uri.host, uri.port )
      n.use_ssl = true

      # Send the payload to the endpoint.
      n.start { |http| http.request( request ) }
    end

    # Post to Teams with curl command.
    def post_with_curl
      url = @settings.webhook_url
      `curl -is -X POST -H "Content-Type:application/json" -d '#{get_body}' '#{url}'`
    end
    
  end
end
