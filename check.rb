#!/usr/bin/env ruby
require 'colorize'
require_relative 'prices'
require_relative 'bitstamp'
require_relative 'kraken'
require_relative 'bitmex'

prices = Prices.new

bitstamp = Bitstamp.new
puts "Bitstamp:".green
print "$#{bitstamp.price_usd}"
print " #{'%.2f' % bitstamp.price_eur}€".yellow
puts prices.get_change(:btc, bitstamp.price_usd)
prices.set(:btc, bitstamp.price_usd)

#bitmex = Bitmex.new
#puts
#puts "Bitmex".green
#puts "Mark: $#{bitmex.mark_price}"
#puts "Bid XBT24H: $#{bitmex.bid_price}"
#puts "Ask XBT24H: $#{bitmex.ask_price}"

puts

kraken = Kraken.new
puts "ETH (Kraken):".green
print "$#{'%.2f' % kraken.price_usd}"
print " #{'%.2f' % kraken.price_eur}€".yellow
puts prices.get_change(:eth, kraken.price_usd)
prices.set(:eth, kraken.price_usd)
