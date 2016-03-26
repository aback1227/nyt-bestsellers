class NYTBestsellers::Scraper

	def self.scrape_bestsellers_by_genre
		array = Array.new
		
		doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/"))

		categories = doc.css(".bookCategory")
		categories.each do |category|
		  h = Hash.new
		  h[:genre] = category.css("h3 a").text.split.collect(&:capitalize).join(' ')
		  h[:url] = category.css("a").attr("href").text
		  h[:books] = category.css("li b").text.split(",").collect{|s| s.split.collect(&:capitalize).join(' ')}
		  array << h
	    end
	    
	    array.delete_if {|hash| hash[:genre] == "" || hash[:genre] == "Combined Print &amp; E-book Fiction" || hash[:genre] == "Combined Print &amp; E-book Nonfiction"}

		#for some reason it wouldn't let me do ("h2 a") in the above 'each' iterator
		pb_non = doc.css(".story")[7]
		h2 = Hash.new
		h2[:genre] = pb_non.css("h2").text.split.collect(&:capitalize).join(' ')
		h2[:url] = pb_non.css("a").attr("href").text
		h2[:books] = pb_non.css("li b").text.split(",").collect{|s| s.split.collect(&:capitalize).join(' ')}
		array << h2
	end

	def self.scrape_book_attributes
		array = Array.new
		doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/"))

		categories = doc.css(".bookCategory")
		categories.each do |category|
		    books = category.css("li")
		    books.each do |book|
	    	  hash = Hash.new
	    	  hash[:title] = book.css("b").text.gsub(",", "").split.collect(&:capitalize).join(' ')
	    	  hash[:author] = book.css("span").text.split(" by ").collect{|w| w.strip}.delete_if(&:empty?).join(" ")
	    	  hash[:genre] = category.css("h3 a").text.split.collect(&:capitalize).join(' ')
	          array << hash
		    end
		end
		array.delete_if {|hash| hash[:genre] == "" || hash[:genre] == "Combined Print &amp; E-book Fiction" || hash[:genre] == "Combined Print &amp; E-book Nonfiction"}
		
		pb_non = doc.css(".story")[7] #specifically targets the 7th div with '.story' class - paperback non-fiction
		books = pb_non.css("li")
		books.each do |book|
		  h = Hash.new
		  h[:title] = book.css("b").text.gsub(",", "").split.collect(&:capitalize).join(' ')
		  h[:author] = book.css("span").text.split(" by ").delete_if(&:empty?)
		  h[:genre] = pb_non.css("h2 a").text
		  array << h
		end

		NYTBestsellers::Genre.all.each do |genre|
		details = Nokogiri::HTML(open(genre.url)).css(".bookDetails")
		  details.each do |attribute|
		  	array.each do |hash|
		  	  	if hash[:title] == attribute.css(".bookName").text.gsub(", ", "").split.collect(&:capitalize).join(' ')
		  	  	   hash[:publisher] = attribute.css(".summary").text.match(/\(.*\)/).to_s.gsub(/[(.)]/, "")
		  	  	   hash[:summary] = attribute.css(".summary").text.match(/\).*\./).to_s.gsub(") ", "")
		  	  	if hash[:genre] == "Paperback Trade Fiction" || hash[:genre] == "Paperback Nonfiction"
		  	  	   hash[:wol] = attribute.css(".weeklyPosition").text
		  	    else
		  	  	   hash[:wol] = attribute.css(".weeklyPosition")[1].text #other genres had two classes of the same name 'weeklyposition'
		  	  	end
		  	    end
		  	end #array
	      end #details
	    end
	array
	end #scrape_book_attributes

	def self.scrape_current_date
		doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/"))
		current_date = doc.css(".element1 p").text
	end
	# def self.scrape_price_rating

	# 	books = Nokogiri::HTML(open("http://www.amazon.com/Books/b/ref=sv_b_3?ie=UTF8&node=549028")).css("div .s9OtherItems")
	# 	array = self.scrape_book_attributes
	# 	array.collect do |hash|
	# 		if books.css(".a-row a").attr("title").text.include?(hash[:title])
	# 			binding.pry
	# 			hash[:url] = "www.amazon.com#{book.css(".a-row a").attr("href").text}"
 # 			end 
	# 	end
	# array
	# end

end	

