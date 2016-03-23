require 'pry'
class NYTBestsellers::Scraper

	def self.scrape_bestsellers_by_genre
		array = Array.new
		
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

	def self.scrape_book_attributes
		array = Array.new

		doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/2016-03-27/overview.html"))
		categories = doc.css(".bookCategory")
		categories.each do |category|
		    books = category.css("li")
		    books.each do |book|
	    	  hash = Hash.new
	    	  hash[:title] = book.css("b").text.gsub(",", "")
	    	  hash[:author] = book.css("span").text.split(" by ").collect{|w| w.strip}.delete_if(&:empty?).join(" ")
	    	  hash[:genre] = category.css("h3 a").text
	          array << hash
		    end
		end
		array.delete_if {|hash| hash[:genre] == "" || hash[:genre] == "COMBINED PRINT &AMP; E-BOOK FICTION" || hash[:genre] == "COMBINED PRINT &AMP; E-BOOK NONFICTION"}
		
		pb_non = doc.css(".story")[7] #specifically targets the 7th div with '.story' class - paperback non-fiction
		books = pb_non.css("li")
		books.each do |book|
		  h = Hash.new
		  h[:title] = book.css("b").text.gsub(",", "")
		  h[:author] = book.css("span").text.split(" by ").delete_if(&:empty?)
		  h[:genre] = pb_non.css("h2 a").text.upcase
		  array << h
		end

		NYTBestsellers::Genre.all.each do |genre|
		info = Nokogiri::HTML(open(genre.url))
		  details = info.css(".bookDetails")
		  details.each do |attribute|
		  	array.each do |hash|
		  	  	if hash[:title] == attribute.css(".bookName").text.gsub(", ", "")
		  	  	   hash[:publisher] = attribute.css(".summary").text.match(/\(.*\)/).to_s.gsub(/[(.)]/, "")
		  	  	   hash[:summary] = attribute.css(".summary").text.match(/\).*\./).to_s.gsub(") ", "")
		  	  	   if hash[:genre] == "PAPERBACK TRADE FICTION" || hash[:genre] == "PAPERBACK NONFICTION"
		  	  	   	  hash[:wol] = attribute.css(".weeklyPosition").text
		  	  	   else
		  	  	      hash[:wol] = attribute.css(".weeklyPosition")[1].text
		  	  	   	end
		  	  	end
		  	end
	      end
	    end
	array
	end #scrape_book_attributes
	

end
