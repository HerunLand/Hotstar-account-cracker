
# watches Block.io addresses for balance changes using SoChain's API

require 'httpclient'
require 'json'
require 'pusher-client'
#require 'logger'

# create 2 wallet addresses

addresses = [] # an array of addresses we'll create
api_key = "edb4-2754-2b6d-5446" # dogecoin api key
