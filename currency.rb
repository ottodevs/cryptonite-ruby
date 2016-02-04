require_relative 'config'

class Currency

  USD = 'usd'
  EUR = 'eur'
  GBP = 'gbp'

  def self.usd
    list.include? USD
  end

  def self.eur
    list.include? EUR
  end

  def self.gbp
    list.include? GBP
  end

  def self.format(value, currency = default)
    case currency
    when USD then "$#{format_price(value)}"
    when EUR then "#{format_price(value)}€"
    when GBP then "#{format_price(value)}£"
    end
  end

  def self.convert_usd(value, prices, target = default)
    case target
    when USD then value
    when EUR then prices.convert_usd_eur(value)
    when GBP then prices.convert_usd_gbp(value)
    end
  end

  def self.list
    currencies = Config.load['currencies']
    currencies ? currencies.gsub(' ', '').downcase.split(',') : [USD]
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
