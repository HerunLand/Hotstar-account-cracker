# create some wallet addresses, fund them with some coins using Block.io's API

require 'httpclient'
require 'json'
require 'bigdecimal'

apiKey = "1f86-055f-1e32-0f9a" # bitcoin testnet

funder_label = "default" # the funding address' label

# create an address (label=demo1)
puts "Creating an address: "
response = HTTPClient.new.get("https://block.io