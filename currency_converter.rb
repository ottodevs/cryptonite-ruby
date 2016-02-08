
require_relative 'providers/bitstamp'
require_relative 'providers/coinfloor'
require_relative 'providers/krompir'
require_relative 'providers/kraken'
require_relative 'providers/bitmex'
require_relative 'currency'

class CurrencyConverter

  def ratio(from, to)
    if from == to
      1
    elsif conv = conversions[[from, to]]
      conv.call
    elsif conv = conversions[[to, from]]
      1 / conv.call
    else
      ratio(from, Currency::USD) / ratio(to, Currency::USD)
    end
  end

private

  # all conversions to or from USD
  def conversions
    @conversions ||= {
      [Currency::USD, Currency::EUR] => lambda { bitstamp.to_eur(1) },
      [Currency::USD, Currency::GBP] => lambda { coinfloor.to_gbp(1) },
      [Currency::BTC, Currency::USD] => lambda { bitstamp.price_usd },
      [Currency::ETH, Currency::USD] => lambda { kraken.price_usd },
      [Currency::KRM, Currency::USD] => lambda { krompir.price_usd }
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

end
