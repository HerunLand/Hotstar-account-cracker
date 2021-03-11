
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

  puts "New address for Network=#{response['data']['network']} is #{new_address}"

  addresses.insert(0, new_address) # add it to our array of addresses
end

# intialize Pusher using SoChain's instructions for realtime balance updates
options = {
    :ws_host => 'slanger1.chain.so', # our server to connect to
    :encrypted => true, # this connection will be encrypted over SSL
    :ws_port => 443, # the server's port to connect to
    :wss_port => 443 # ...
}

# create the socket we shall use for updates
socket = PusherClient::Socket.new('e9f5cc20074501ca7395', options)

# subscribe to the channel for balance updates for each address
addresses.each do |current_address|
  socket.subscribe("address_doge_#{current_address}")
end

# alert us when the balance changes for any given address
socket.bind('balance_update') do |data|
  data = JSON.parse(data)
  balance_change = data['value']['balance_change']
  current_address = data['value']['address']
