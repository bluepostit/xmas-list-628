require 'open-uri'
require 'nokogiri'

def search_etsy(search_term)
  # Should return an array of items as HASHES.
  results = []

  # 1. We get the HTML page content thanks to open-uri
  html_content = URI.open("https://www.etsy.com/search?q=#{search_term}").read
  # 2. We build a Nokogiri document from this file
  doc = Nokogiri::HTML(html_content)

  # 3. We search for the correct elements containing the items' title in our HTML doc
  doc.search('.v2-listing-card .v2-listing-card__info .text-body').first(10).each do |element|
    # 4. For each item found, we extract its title
    name = element.text.strip
    results << { name: name, bought: false }
  end
  return results
end
