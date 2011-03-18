require "rubygems"

# _DONE_: usar nova api do twitter : http://rubydoc.info/gems/twitter/1.1.2/frames
module TwitterBot
  activate = false
  activate = true if require "twitter"

  if activate
    def self.tweet msg
      # Certain methods require authentication. To get your Twitter OAuth credentials,
      # register an app at http://dev.twitter.com/apps
      Twitter.configure do |config|
        config.consumer_key = "xiPQ7mRYsiKUefOXGKqzRA"
        config.consumer_secret = "TKRLNWIzTCMXlMhpWCsAZ5KlEUoIr5N9gCvIRfjvM"
        config.oauth_token = "124340077-8SYuc9DJytcHhb9FcXoVsqQb978WjaR34WnGHwYw"
        config.oauth_token_secret = "0rMLWf0wHUWBv6D2lo4Ofo9nXWzIBfNR4FopTr5zKo"
      end
      Twitter.update(msg + " #rsonline_")
    end
  else
    def self.tweet msg
      Verbose.to_debug("Twitter não ativo.\nSuposta msg: #{msg}")
    end
  end
end
