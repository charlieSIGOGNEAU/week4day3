require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

doc = Nokogiri::HTML(URI.open("https://coinmarketcap.com/all/views/all/"))
hash={}
cryptos=doc.xpath("//tr/td[2]/div/a[2]").map {|crypto| crypto.text }
valeurs=doc.xpath("//tr/td[5]/div/span").map {|crypto| crypto.text.gsub('$', '').gsub(',', '').to_f }
hash = cryptos.zip(valeurs).to_h
puts hash

# hash={}
# doc.xpath("//tr/td[2]/div/a[2]").length.times do |i|
#     hash[doc.xpath("//tr[#{i+1}]/td[2]/div/a[2]").text]=doc.xpath("//tr[#{i+1}]/td[5]/div/span").text.gsub('$', '').gsub(',', '').to_f
# end
# puts hash
