require_relative 'config'

class Currency

  BTC = :btc
  USD = :usd
  KRM = :krm
  ETH = :eth
  EUR = :eur
  GBP = :gbp

  def self.format(value, currency = default)
    case currency
    when USD then "$#{format_price(value)}"
    when EUR then "#{format_price(value)}€"
    when GBP then "#{format_price(value)}£"
    when KRM then "#{format_price(value)}●"
    end
  end

  def self.convert_usd(value, currency_converter, target = default)
    case target
    when USD then value
    when EUR then currency_converter.convert_usd_eur(value)
    when GBP then currency_converter.convert_usd_gbp(value)
    when KRM then currency_converter.convert_usd_krm(value)
    end
  end

  def self.list
    currencies = Config.load['currencies']
    currencies ? currencies.gsub(' ', '').downcase.split(',').map { |cur| cur.to_sym } : [USD]
  end

  def self.default
    list ? list[0] : USD
  end

private

  # 1000000.00 => 1,000,000.00
  def self.format_price(num)
    num = num.to_s
    decimals = nil
    num, decimals = num.split('.') if num.include?('.')
    num = num.reverse.gsub(/...(?=.)/,'\&,').reverse
    decimals ? "#{num}.#{decimals}" : num
  end

end
