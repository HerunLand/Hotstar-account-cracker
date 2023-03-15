
# create some wallet addresses, fund them with some coins using Block.io's API

require 'httpclient'
require 'json'
require 'bigdecimal'

api_key = 'a4de-43a7-3fa6-f19a' # dogecoin testnet

# create an address, label=demo1
response = HTTPClient.new.get("https://block.io/api/v1/get_new_address/?api_key=#{api_key}&label=demo1")