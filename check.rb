#!/usr/bin/env ruby
require 'colorize'
require_relative 'config'
require_relative 'prices'
require_relative 'portfolio'

prices = Prices.new

# Show current prices and price changes

puts "BTC".green
print "Bitstamp: $#{prices.price(Prices::BTC).round}"
print " #{prices.convert_usd_eur(prices.price(Prices::BTC)).round}€".yellow
puts prices.get_change(Prices::BTC)

if Config.load['futures']
  bitmex = Bitmex.new
  puts
  puts "Bitmex".green
  puts "Mark: $#{bitmex.mark_price}"
  puts "Bid XBT24H: $#{bitmex.bid_price}"
  puts "Ask XBT24H: $#{bitmex.ask_price}"
end

puts "\nETH".green
print "Kraken: $#{'%.2f' % prices.price(Prices::ETH)}"
print " #{'%.2f' % prices.convert_usd_eur(prices.price(Prices::ETH))}€".yellow
puts prices.get_change(Prices::ETH)

# Show portfolio

Portfolio.new.show(prices)
