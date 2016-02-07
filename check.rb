#!/usr/bin/env ruby
require 'colorize'
require_relative 'config'
require_relative 'currency'
require_relative 'currency_converter'
require_relative 'prices'
require_relative 'portfolio'

prices = Prices.new
currency_converter = CurrencyConverter.new(prices)

# Show current prices and price changes

puts "BTC".green
print "Bitstamp: "
price = prices.price(Currency::BTC).round
Currency.list.each_with_index do |currency, index|
  print " " unless index == 0
  converted = Currency.convert_usd(price, currency_converter, currency).round
  output = "#{Currency.format(converted, currency)}"
  print index == 0 ? output.colorize(:yellow) : output
end
puts prices.get_change(Currency::BTC)

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
price = prices.price(Currency::ETH)
Currency.list.each_with_index do |currency, index|
  print " " unless index == 0
  converted = '%.2f' % Currency.convert_usd(price, currency_converter, currency)
  output = "#{Currency.format(converted, currency)}"
  print index == 0 ? output.colorize(:yellow) : output
end
puts prices.get_change(Currency::ETH)

# Show portfolio

Portfolio.new.show(prices, currency_converter)
