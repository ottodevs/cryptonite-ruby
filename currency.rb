require_relative 'config'

class Currency

  BTC = :btc
  USD = :usd
  KRM = :krm
  ETH = :eth
  EUR = :eur
  GBP = :gbp

  def self.symbol(currency)
    { BTC => { append: 'Ƀ' },
      USD => { prepend: '$' },
      KRM => { append: '🍠' },
      ETH => { append: 'eth' },
      EUR => { append: '€' },
      GBP => { append: '£' }
    }[currency]
  end

  def self.format(value, currency = default)
    if self.symbol(currency)[:prepend]
      "#{self.symbol(currency)[:prepend]}#{format_price(value)}"
    else
      "#{format_price(value)}#{self.symbol(currency)[:append]}"
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
