#!/usr/bin/env ruby
require 'colorize'
require_relative 'bitstamp'
require_relative 'kraken'

bitstamp = Bitstamp.new
puts "BTC:".green + " $#{bitstamp.price_usd} / #{bitstamp.price_eur}€"

kraken = Kraken.new
puts "ETH:".green + " $#{kraken.price_usd} / #{kraken.price_eur}€"
