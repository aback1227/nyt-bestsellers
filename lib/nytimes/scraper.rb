require 'pry'
class NYTBestsellers::Scraper

	def self.bestsellers
		array = Array.new
		hash = Hash.new
		doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/2016-03-27/overview.html"))
		
		categories = doc.css(".bookCategory")
		categories.each do |category|
          hash[category.css("h3 a").text] = {books:[]}
       	  hash[category.css("h3 a").text][:books] = category.css("li b").text.split(",").flatten
	    end
	    hash.delete_if {|key, value| key.empty? || key == "COMBINED PRINT &AMP; E-BOOK FICTION" || key == "COMBINED PRINT &AMP; E-BOOK NONFICTION"}
		
		#for some reason it wouldn't let me do ("h2 a") in the above 'each' iterator
		pb_non = doc.css(".story")[7]
	    hash[pb_non.css("h2").text.upcase] = {books:[]}
	    hash[pb_non.css("h2").text.upcase][:books] = pb_non.css("li b").text.split(",").flatten
	   
	end

end
