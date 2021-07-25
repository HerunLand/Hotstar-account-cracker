# create some wallet addresses, fund them with some coins using Block.io's API

require 'httpclient'
require 'json'
require 'bigdecimal'

apiKey = "1f86-055f-1e32-0f9a" # bitcoin testnet

funder_label = "default" # the funding address' label

# create an address (label=demo1)
puts "Creating an address: "
response = HTTPClient.new.get("https://block.io/api/v1/get_new_address/?api_key=#{apiKey}\&label=demo1")
response = JSON.parse(response.content)

puts "Address created: #{response['data']['address']} for Network=#{response['data']['network']}" if response['status'].eql?('success')
puts "Address for the given label already existed, nothing's changed." if !response['status'].eql?('success')

# fund it with funder_label
response = HTTPClient.new.p