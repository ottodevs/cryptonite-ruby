require_relative 'currency'

class CurrencyConverter

  def initialize(prices)
    @prices = prices
  end

  def convert_usd_eur(usd)
    convert(usd, Currency::USD, Currency::EUR, @prices)
  end

  def convert_usd_gbp(usd)
    convert(usd, Currency::USD, Currency::GBP, @prices)
  end

  def convert_usd_krm(usd)
    convert(usd, Currency::USD, Currency::KRM, @prices)
  end

private

  def convert(value, source, target, prices)
    if source == Currency::USD
      case target
      when Currency::EUR
        @prices.send(:bitstamp).convert_usd_eur(value)
      when Currency::GBP
        @prices.send(:coinfloor).convert_usd_gbp(value)
      when Currency::KRM
        @prices.send(:krompir).convert_usd_krm(value)
      end
    end
  end

end
