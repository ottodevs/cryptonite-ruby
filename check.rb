#!/usr/bin/env ruby
require 'colorize'
require_relative 'config'
require_relative 'prices'
require_relative 'portfolio'

prices = Prices.new
currencies = Config.load['currencies']

# Show current prices and price changes

puts "BTC".green
print "Bitstamp: "
print "$#{prices.price(Prices::BTC).round}" if currencies.include?('usd') or !currencies
print " #{prices.convert_usd_eur(prices.price(Prices::BTC)).round}€".yellow if currencies.include?('eur')
print " #{prices.convert_usd_gbp(prices.price(Prices::BTC)).round}£".yellow if currencies.include?('gbp')
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
print "Kraken: "
print "$#{'%.2f' % prices.price(Prices::ETH)}" if currencies.include?('usd') or !currencies
print " #{'%.2f' % prices.convert_usd_eur(prices.price(Prices::ETH))}€".yellow if currencies.include?('eur')
print " #{'%.2f' % prices.convert_usd_gbp(prices.price(Prices::ETH))}£".yellow if currencies.include?('gbp')
puts prices.get_change(Prices::ETH)

# Show portfolio

Portfolio.new.show(prices)
