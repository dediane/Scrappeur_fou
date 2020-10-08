require 'nokogiri'
require 'open-uri'

page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

all_currency_symbols = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div').map{|x| x.text}
all_currency_prices = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a').map{|x| x.text.delete('$').gsub(',','').to_f}

def get_array_of_hash(all_currency_symbols, all_currency_prices)
  array = []
  if all_currency_prices.length == all_currency_symbols.length
    
    all_currency_symbols.length.times do |i|
      result_hash = {}
      result_hash[all_currency_symbols[i]] = all_currency_prices[i]
      array.push(result_hash)
    end
  end
  return array
end

final_hash = get_array_of_hash(all_currency_symbols, all_currency_prices)
puts final_hash
