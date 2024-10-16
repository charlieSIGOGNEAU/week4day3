require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def get_townhall_email(townhall_url)
  doc = Nokogiri::HTML(URI.open(townhall_url))
  mail = doc.css('.send-mail').text 
  mail
end

def get_townhall_urls(numero)
  doc = Nokogiri::HTML(URI.open("https://lannuaire.service-public.fr/navigation/ile-de-france/val-d-oise/mairie?page=#{numero}"))
  ville = doc.css('a.fr-link').map { |node| node.text.gsub("Mairie - ", "") } .drop(4)
  townhall_url = doc.css('a.fr-link').map { |node| node['href'] } .drop(4)
  townhall_email = townhall_url.map { |lien| get_townhall_email(lien)}
  hash = ville.zip(townhall_email).to_h
end

hash={}
7.times do |i|
  hash=hash.merge(get_townhall_urls(i+1))
end

puts hash

