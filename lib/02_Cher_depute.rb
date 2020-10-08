require 'nokogiri'
require 'open-uri'

def get_one_mail(url_depute)
  page = Nokogiri::HTML(URI.open(url_depute))
  mail = page.xpath'/html/body/div/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a/text()'
  return mail.to_s
end 

def get_array_urls
  page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  array_of_urls = page.xpath('/html/body/div/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li/a/@href').map{|x| "http://www.assemblee-nationale.fr" + x.text }
end

def get_array_names
  page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
  array_of_names = page.xpath('/html/body/div/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li').map{|x| x.text.split}
end


#puts get_array_urls
#puts get_array_urls.length
puts get_array_names
#puts get_array_last_names