require 'rubygems'
require 'nokogiri'
require 'open-uri'
require 'pry'

def get_email(townhall_url)
  doc = Nokogiri::HTML(URI.open(townhall_url))
  mail=doc.xpath("//div/div/div/section[2]/div/ul/li[1]/a/span[2]").text 
  mail
end

def tableau_creation(prenoms,noms,mails)
  tabeleau_entet=["first_name","last_name","email"]
  prenom_nom_mail=[]
  tableau_each=[]
  prenoms.length.times do |i|
    prenom_nom_mail=[prenoms[i],noms[i],mails[i]]
    tableau_each << tabeleau_entet.zip(prenom_nom_mail).to_h
    end
  tableau_each
end

def get_depute (n)
  doc = Nokogiri::HTML(URI.open("https://www2.assemblee-nationale.fr/deputes/liste/alphabetique"))
  prenom_noms = doc.css('a[href*="/deputes/fiche/"]').take(n).map {|nom| nom.text.gsub("M.", "").gsub("Mme", "")}
  prenoms=prenom_noms.map { |prenom_nom| prenom_nom.split.first}
  noms=prenom_noms.map { |prenom_nom| prenom_nom.split.drop(n)}
  links= doc.css('a[href*="/deputes/fiche/"]').take(5).map {|lien| "https://www2.assemblee-nationale.fr"+lien['href']}
  mails= links.map {|mail| get_email(mail)}
  tableau_final=tableau_creation(prenoms,noms,mails)
  tableau_final
end

puts "choisi le nombre de debuté voulu. attention environ 5s par debuté"
puts get_depute(gets.chomp.to_i)