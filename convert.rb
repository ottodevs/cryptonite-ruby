require 'readline'
require 'colorize'
require_relative 'currency_converter'

Readline.readline("Query (ex. 50 usd in btc): ", true).strip.downcase =~ /(\d+)\s*(.*?)\s+in\s+(.*?)$/
amount = $1.to_i
from = $2.to_sym
to = $3.to_sym

converter = CurrencyConverter.new
converted = amount * converter.ratio(from, to)
puts "#{amount} #{from} = #{'%0.2f' % converted} #{to}".yellow
