
# prints the current prices for Bitcoin, Dogecoin, and Litecoin against USD from all available exchanges

require 'httpclient'
require 'json'

api_key = '0223-428b-9ecd-120a' # bitcoin from block.io

response = HTTPClient.new.get("https://block.io/api/v1/get_current_price/?api_key=#{api_key}&price_base=USD")