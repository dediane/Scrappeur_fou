require 'nokogiri'
require 'open-uri'

def get_townhall_email(townhall_url)
  page = Nokogiri::HTML(URI.open(townhall_url))
  mail = page.xpath'/html/body/div/main/section[2]/div/table/tbody/tr[4]/td[2]/text()'
  return mail.to_s
end

def get_townhall_urls
  page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
  array_of_urls  = page.xpath('//a[@class="lientxt"]/@href').map{|x| x.text[1..-1]}
  array_of_urls.length.times do |i|
    array_of_urls[i] = "https://www.annuaire-des-mairies.com" + array_of_urls[i]
  end
  return array_of_urls
end

def get_townhall_names
  page = Nokogiri::HTML(URI.open('https://www.annuaire-des-mairies.com/val-d-oise.html'))
  array_of_names = page.xpath('//a[@class="lientxt"]').map{|x| x.text}
  return array_of_names
end

def get_array_of_mails
  array_of_urls = get_townhall_urls
  array_of_mails = array_of_urls.map{|url|
  get_townhall_email(url)
  }
  return array_of_mails
end

def perform 
  emails = get_array_of_mails
  names = get_townhall_names
  puts hash = Hash[names.zip(emails)].each_slice(1).map(&:to_h)
end

perform