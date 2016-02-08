
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
      [Currency::GBP, Currency::USD] => lambda { coinfloor.gbp_to_usd },
      [Currency::EUR, Currency::USD] => lambda { bitstamp.eur_to_usd },
      [Currency::BTC, Currency::USD] => lambda { bitstamp.btc_to_usd },
      [Currency::ETH, Currency::USD] => lambda { kraken.eth_to_usd },
      [Currency::KRM, Currency::USD] => lambda { krompir.krm_to_usd }
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
