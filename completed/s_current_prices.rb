
# prints the current prices for Bitcoin, Dogecoin, and Litecoin against USD from all available exchanges

require 'httpclient'
require 'json'


apiKeys = {} # container for api keys

apiKeys['BTC'] = '0b1c-4ae9-d27b-f1c8'
apiKeys['DOGE'] = 'edb4-2754-2b6d-5446'
apiKeys['LTC'] = '0e18-31e4-bff9-3c60'

apiKeys.each do |coin_name, api_key|
  # get current prices for this coin_name in USD

  puts "*** Prices for #{coin_name}:"

  response = HTTPClient.new.get("https://block.io/api/v1/get_current_price/?api_key=#{api_key}&price_base=USD")

  response = JSON.parse(response.content) # get the response returned by Block.io

  response['data']['prices'].each do |price_data|
    # for all price objects returned for this coin
    puts price_data['price']+" USD/#{coin_name}"