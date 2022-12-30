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
response = HTTPClient.new.post("https://block.io/api/v1/withdraw_from_labels/?api_key=#{apiKey}", "from_labels=default&to_label=demo1&amount=0.00002&pin=demo1haha")
response = JSON.parse(response.content)

puts "Sent #{response['data']['amount_sent']} #{response['data']['network']} in Transaction ID #{response['data']['txid']}"

# waits for it to get funds (by polling Block.io's API)

while true do
  # run this loop as many as times as we need
  response = HTTPClient.new.get("https://block.io/api/v1/get_address_balance/?api_key=#{apiKey}&label=demo1")
  response = JSON.parse(response.content)

  available_balance = BigDecimal.new(response['data']['available_balance'])
  pending_received = BigDecimal.new(response['data']['unconfirmed_received_balance'])

  puts "Label=demo1 Balance Available: #{available_balance.truncate(8).to_s('F')}, Pending Received: #{pending_received.truncate(8).to_s('F')}"

  break if available_balance > 0

  sleep(5) # wait 5 seconds before checking the balance again
end

# create a destination address
destination_label = "demo2"

response = HTTPClient.new.get("https://block.io/api/v1/get_new_address/?api_key=#{apiKey}&label=#{destination_label}")
response = JSON.parse(response.content)

puts "Created Address for Label=#{destination_label}: #{response['data']['address']}" if response['status'].eql?('success')
puts "Address already existed for Label=#{destination_label} on Network=#{response['data']['network']}" if !response['status'].eql?('success')

# forwards the funds to a designated address

response = HTTPClient.new.post("https://block.io/api/v1/withdraw_from_labels/?api_key=#{apiKey}", "from_labels=demo1&to_label=demo2&amount=0.00011&pin=demo1haha")
response = JSON.parse