
# watches Block.io addresses for balance changes using SoChain's API

require 'httpclient'
require 'json'
require 'pusher-client'
#require 'logger'

# create 2 wallet addresses

addresses = [] # an array of addresses we'll create
api_key = "edb4-2754-2b6d-5446" # dogecoin api key

2.times do
  # create an address
  response = HTTPClient.new.get("https://block.io/api/v1/get_new_address/?api_key=#{api_key}")

  response = JSON.parse(response.content)

  new_address = response['data']['address'] # the new random address that was created for us