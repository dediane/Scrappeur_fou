require 'nokogiri'
require 'open-uri'

def get_crypto
  page = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))

  all_currency_symbols = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[3]/div').map{|x| x.text}
  all_currency_prices = page.xpath('/html/body/div[1]/div[1]/div[2]/div[1]/div[2]/div/div[2]/div[3]/div/table/tbody/tr/td[5]/a').map{|x| x.text.delete('$').gsub(',','').to_f}

return hash = Hash[all_currency_symbols.zip(all_currency_prices)].each_slice(1).map(&:to_h)
end

puts get_crypto