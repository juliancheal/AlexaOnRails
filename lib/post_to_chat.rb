require 'faraday'
require 'json'
require 'uri'

class PostToChat

  def initialize(chat_url)
    @chat_url = chat_url
  end

  def post_message(message)
    @conn = Faraday.new(url: "#{@chat_url}/api/messages")
    @conn.post do |req|
      req.headers['Content-Type'] = 'application/json'
      req.body = "{
      \"api_key\": \"cbe304785c9a7291883816b0b090319fcf9c76e8d9f17b39a2daac0aceffc736d0d1b2e693c2aeda40d9629868396c7924016f7be48b60f49e9dbc94e303e1d1\",
      \"message\": {
        \"user\": {\"name\": \"Alexa\"},
      	  \"content\": \"#{message}\"
      	}
      }"
    end
  end
end
