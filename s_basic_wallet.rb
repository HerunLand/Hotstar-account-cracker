
# create some wallet addresses, fund them with some coins using Block.io's API

require 'httpclient'
require 'json'
require 'bigdecimal'

api_key = 'a4de-43a7-3fa6-f19a' # dogecoin testnet

# create an address, label=demo1
response = HTTPClient.new.get("https://block.io/api/v1/get_new_address/?api_key=#{api_key}&label=demo1")
response = JSON.parse(response.content)

puts "Address created was: #{response['data']['address']} for Network=#{response['data']['network']}" if response['status'].eql?('success')

# fund it with some coins from label=default (testnet)
response = HTTPClient.new.post("https://block.io/api/v1/withdraw_from_labels/?api_key=#{api_key}", "amount=4.5&from_labels=default&to_label=demo1&pin=demo1haha")
response = JSON.parse(response.content)

puts "Withdrawal succeeded. Sent #{response['data']['amount_sent']} DOGETEST in Transaction ID #{response['data']['txid']}"

amount_available = BigDecimal.new('0.0')
network_fee = BigDecimal.new('1.0') # 1 dogecoin network fee

# wait for it to get funds (by polling Block.io's API)
while true do
  # keep checking block.io to see if demo1 has received the money or not
  response = HTTPClient.new.get("https://block.io/api/v1/get_address_balance/?api_key=#{api_key}&label=demo1")