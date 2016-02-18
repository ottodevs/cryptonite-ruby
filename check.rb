#!/usr/bin/env ruby
require 'colorize'
require_relative 'config'
require_relative 'currency'
require_relative 'currency_converter'
require_relative 'prices'
require_relative 'portfolio'
require_relative 'providers/lib/connection'
require_relative 'providers/bitmex'

prices = Prices.new
basis = Config.load["basis"] || Currency::USD
exchanges = Config.load['exchanges'] || Currency::DEFAULT_EXCHANGES
converter = CurrencyConverter.new(basis)

# Show current prices and price changes

puts "BTC".green
exch = exchanges ? exchanges['btc'] : 'coinbase'
print "#{exch.capitalize}: "

price = converter.ratio(Currency::BTC, Currency::USD, exchanges).round
Currency.list.each_with_index do |currency, index|
  print " " unless index == 0
  converted = price * converter.ratio(Currency::USD, currency, exchanges)
  output = "#{Currency.format(converted.round, currency)}"
  print index == 0 ? output.colorize(:yellow) : output
end
puts prices.get_change(Currency::BTC, converter, exchanges)

if Config.load['futures']
  bitmex = Bitmex.new
  puts
  puts "Bitmex".green
  puts "Mark: $#{bitmex.mark_price}"
  puts "Bid XBT24H: $#{bitmex.bid_price}"
  puts "Ask XBT24H: $#{bitmex.ask_price}"
end

puts "\nETH".green
exch = exchanges ? exchanges['eth'] : 'kraken'
print "#{exch.capitalize}: "

price = converter.ratio(Currency::ETH, Currency::USD, exchanges)
Currency.list.each_with_index do |currency, index|
  print " " unless index == 0
  converted = price * converter.ratio(Currency::USD, currency, exchanges)
  output = Currency.format('%.2f' % converted, currency)
  print index == 0 ? output.colorize(:yellow) : output
end
puts prices.get_change(Currency::ETH, converter, exchanges)

# Show portfolio

Portfolio.new.show(prices, converter)

puts "\nWarning: Used cache".red if Connection.cache_used
