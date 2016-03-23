require 'pry'
class NYTBestsellers::Scraper

	def self.scrape_bestsellers_by_genre
		array = Array.new
		hash = Hash.new
		
		doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/2016-03-27/overview.html"))
		
		categories = doc.css(".bookCategory")
		categories.each do |category|
		  h = Hash.new
		  h[:genre] = category.css("h3 a").text
		  h[:url] = category.css("a").attr("href").text
		  h[:books] = category.css("li b").text.split(",").flatten
		  array << h
	    end
	    
	    array.delete_if {|hash| hash[:genre] == "" || hash[:genre] == "COMBINED PRINT &AMP; E-BOOK FICTION" || hash[:genre] == "COMBINED PRINT &AMP; E-BOOK NONFICTION"}

		#for some reason it wouldn't let me do ("h2 a") in the above 'each' iterator
		pb_non = doc.css(".story")[7]
		h2 = Hash.new
		h2[:genre] = pb_non.css("h2").text.upcase
		h2[:url] = pb_non.css("a").attr("href").text
		h2[:books] = pb_non.css("li b").text.split(",").flatten
		array << h2
	end
end
