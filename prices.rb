require 'colorize'
require 'json'

class Prices

  BTC = :btc
  ETH = :eth

  def initialize
    load
  end

  def get(crypto)
    @prices[crypto.to_s] && @prices[crypto.to_s].to_f
  end

  def set(crypto, price)
    @prices[crypto.to_s] = price
    save
  end

  def get_change(crypto, current_price)
    if old_price = self.get(crypto) and old_price
      if current_price > old_price
        percentage_increase = 100 * (current_price - old_price) / old_price
        return " (+#{'%2.1f' % percentage_increase}%)".green if (percentage_increase * 10).round / 10 > 0
      elsif current_price < old_price
        percentage_decrease = 100 * (old_price - current_price) / old_price
        return " (-#{'%2.1f' % percentage_decrease}%)".red if (percentage_decrease * 10).round / 10 > 0
      end
    end
    " (=)".green
  end

private

  def file
    File.join(File.dirname(__FILE__), 'prices.json')
  end

  def save
    File.open(file, 'w') { |f| f.puts(@prices.to_json) }
  end

  def load
    @prices ||= File.exists?(file) ? JSON.parse(File.read(file)) : {}
  end

end
