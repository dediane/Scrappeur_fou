require 'nokogiri'
require 'open-uri'

def get_one_mail(url_depute)
  page = Nokogiri::HTML(URI.open(url_depute))
  mail = page.xpath'/html/body/div/div[3]/div/div/div/section[1]/div/article/div[3]/div/dl/dd[4]/ul/li[2]/a/text()'
  return mail.to_s
end 

def get_page
  page = Nokogiri::HTML(URI.open('http://www2.assemblee-nationale.fr/deputes/liste/alphabetique'))
end

def get_array_urls
  page = get_page
  array_of_urls = page.xpath('/html/body/div/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li/a/@href').map{|x| "http://www2.assemblee-nationale.fr" + x.text }
end

def get_array_first_names
  page = get_page
  array_of_names = page.xpath('/html/body/div/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li').map{|x| x.text.split.delete_at(1)}
end

def get_array_last_names
  page = get_page
  array_of_names = page.xpath('/html/body/div/div[3]/div/div/section/div/article/div[3]/div/div[3]/div/ul/li').map{|x| x.text.split}
  array_of_names = array_of_names.collect{|x|x[2..-1].join(" ")}
end

def get_array_mails
  array_of_urls = get_array_urls
  array_of_mails = array_of_urls.map{|url| get_one_mail(url)}
end


def make_final_array
  first_names = get_array_first_names
  last_names = get_array_last_names
  #emails = get_array_mails
  array = []
  
  if first_names.length == last_names.length
    first_names.length.times do |i|
      final_hash = {}
      final_hash["First name:"] = first_names[i] 
      final_hash["Last name:"] = last_names[i] 
      #final_hash["Emails:"] = emails[i]
      array << final_hash
    end
    return array
  end
end






#puts get_array_urls
#puts get_array_urls.length
#puts get_array_first_names
#puts get_array_mails
#puts get_array_last_names
puts make_final_array