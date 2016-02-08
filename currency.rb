require_relative 'config'

class Currency

  BTC = :btc
  USD = :usd
  KRM = :krm
  ETH = :eth
  EUR = :eur
  GBP = :gbp

  def self.symbol(currency)
    { BTC => { postfix: 'Ƀ' },
      USD => { prefix: '$' },
      KRM => { postfix: '🍠' },
      ETH => { postfix: 'eth' },
      EUR => { postfix: '€' },
      GBP => { postfix: '£' }
    }[currency]
  end

  def self.format(value, currency = default)
    if self.symbol(currency)[:prefix]
      "#{self.symbol(currency)[:prefix]}#{format_price(value)}"
    else
      "#{format_price(value)}#{self.symbol(currency)[:postfix]}"
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
