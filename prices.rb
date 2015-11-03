#!/usr/bin/env ruby
require 'colorize'
require_relative 'bitstamp'
require_relative 'kraken'
require_relative 'bitmex'

bitstamp = Bitstamp.new
puts "Bitstamp:".green + " $#{bitstamp.price_usd} / #{bitstamp.price_eur}€"

bitmex = Bitmex.new
puts
puts "Bitmex".green
puts "Mark: $#{bitmex.mark_price}"
puts "Bid : $#{bitmex.bid_price}"
puts "Ask : $#{bitmex.ask_price}"

puts

kraken = Kraken.new
puts "ETH (Kraken):".green + " $#{kraken.price_usd} / #{kraken.price_eur}€"
