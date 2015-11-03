#!/usr/bin/env ruby
require 'colorize'
require_relative 'bitstamp'
require_relative 'kraken'
require_relative 'bitmex'

bitstamp = Bitstamp.new
puts "Bitstamp:".green
puts "$#{bitstamp.price_usd}"
puts "#{bitstamp.price_eur}€"

bitmex = Bitmex.new
puts
puts "Bitmex".green
puts "Mark: $#{bitmex.mark_price}"
puts "Bid XBT24H: $#{bitmex.bid_price}"
puts "Ask XBT24H: $#{bitmex.ask_price}"

puts

kraken = Kraken.new
puts "ETH (Kraken):".green
puts "$#{kraken.price_usd}"
puts "#{kraken.price_eur}€"
