require 'json'

class Cache

  FILE = File.join(File.dirname(__FILE__), '../../cache.json')

  def set(key, obj)
    @cache ||= load
    @cache[key] = obj
    save
  end

  def get(key)
    @cache ||= load
    @cache[key]
  end

private

  def load
    File.exists?(FILE) ? JSON.parse(File.read(FILE)) : {}
  end

  def save
    File.open(FILE, 'w') { |file| file.puts(@cache.to_json) }
  end

end
