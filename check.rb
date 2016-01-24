#!/usr/bin/env ruby
require 'colorize'
require_relative 'prices'
require_relative 'portfolio'

prices = Prices.new
prices.show

Portfolio.new.show(prices)
