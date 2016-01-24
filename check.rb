#!/usr/bin/env ruby
require 'colorize'
require_relative 'config'
require_relative 'prices'
require_relative 'bitstamp'
require_relative 'kraken'
require_relative 'bitmex'

prices = Prices.new

if File.exists?(File.join(File.dirname(__FILE__), '.debug'))
  puts "DEBUG: #{prices.inspect}"
end

bitstamp = Bitstamp.new
puts "BTC".green
print "Bitstamp: $#{bitstamp.price_usd}"
print " #{'%.2f' % bitstamp.price_eur}€".yellow
puts prices.get_change(:btc, bitstamp.price_usd)
prices.set(:btc, bitstamp.price_usd)

# bitmex = Bitmex.new
# puts
# puts "Bitmex".green
# puts "Mark: $#{bitmex.mark_price}"
# puts "Bid XBT24H: $#{bitmex.bid_price}"
# puts "Ask XBT24H: $#{bitmex.ask_price}"

puts

kraken = Kraken.new
puts "ETH".green
print "Kraken: $#{'%.2f' % kraken.price_usd}"
print " #{'%.2f' % kraken.price_eur}€".yellow
puts prices.get_change(:eth, kraken.price_usd)
prices.set(:eth, kraken.price_usd)

if config = Config.load['crypto']

  def format_price(num)
    num.to_s.reverse.gsub(/...(?=.)/,'\&.').reverse
  end

  total = 0
  puts "\nTotal\n".green

  if btc = config['btc']
    sum_btc = btc['amount'].to_f * bitstamp.price_eur
    total += sum_btc
  end

  if eth = config['eth']
    sum_eth = eth['amount'].to_f * kraken.price_eur
    total += sum_eth
  end

  if total > 0
    puts "ETH: #{format_price(sum_eth.round)}€ (#{(100.0 * sum_eth / total).round}%)"
    puts "BTC: #{format_price(sum_btc.round)}€ (#{(100.0 * sum_btc / total).round}%)"
    puts "Sum: #{format_price(total.round)}€".yellow
  end

end
