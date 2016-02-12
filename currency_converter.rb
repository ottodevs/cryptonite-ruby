
require_relative 'providers/bitstamp'
require_relative 'providers/coinfloor'
require_relative 'providers/krompir'
require_relative 'providers/kraken'
require_relative 'providers/poloniex'
require_relative 'currency'
require_relative 'util'

class CurrencyConverter

  def initialize(basis)
    @basis = basis.to_sym
  end

  def ratio(from, to)
    log_conversion(from: from, to: to, basis: @basis)

    if from == to
      1
    elsif conv = conversions[@basis][[from, to]]
      conv.call
    elsif conv = conversions[@basis][[to, from]]
      1 / conv.call
    else
      ratio(from, @basis) * ratio(@basis, to)
    end
  end

private

  def log_conversion(options = {})
    log "Convert: #{options[:from]} to #{options[:to]}, basis: #{options[:basis]}"
  end

  # conversions are per basis,
  # has to provide all conversions either from- or -to basis
  def conversions
    @conversions ||= {
      Currency::USD => { # all conversions to or from USD
        [Currency::GBP, Currency::USD] => lambda { coinfloor.gbp_to_usd },
        [Currency::EUR, Currency::USD] => lambda { bitstamp.eur_to_usd },
        [Currency::BTC, Currency::USD] => lambda { bitstamp.btc_to_usd },
        [Currency::ETH, Currency::USD] => lambda { kraken.eth_to_usd },
        [Currency::KRM, Currency::USD] => lambda { krompir.krm_to_usd }
      },
      Currency::BTC => { # all conversions to or from BTC
        [Currency::BTC, Currency::GBP] => lambda { coinfloor.btc_to_gbp },
        [Currency::BTC, Currency::EUR] => lambda { bitstamp.btc_to_eur },
        [Currency::BTC, Currency::USD] => lambda { bitstamp.btc_to_usd },
        [Currency::ETH, Currency::BTC] => lambda { kraken.eth_to_btc },
        [Currency::KRM, Currency::BTC] => lambda { krompir.krm_to_btc }
      }
    }
  end

  def bitstamp
    @bitstamp ||= Bitstamp.new
  end

  def coinfloor
    @coinfloor ||= Coinfloor.new
  end

  def krompir
    @krompir ||= Krompir.new
  end

  def kraken
    @kraken ||= Kraken.new
  end

  def poloniex
    @poloniex ||= Poloniex.new
  end

end
