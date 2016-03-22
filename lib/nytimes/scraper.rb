require 'pry'
class NYTBestsellers::Scraper

	def self.scrape_categories
		array = Array.new
		hash = Hash.new
		hash[:categories] = Hash.new
		doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/2016-03-27/overview.html"))
		
		categories = doc.css(".singleRule")
		categories.each do |category|
          hash[:categories] = category.css("h3 a").text
          hash.each do |key, value|
          	binding.pry
          end
          # hash[category.css("h3 a").text] = category.css("li b")
	    end

		array << doc.css(".singleRule h2 a")[1].text.upcase

		categories.each do |category|
			array << category.text
		end
		array.delete_at(1)
		array.delete_at(1)
		# array.collect! { |string| string.split(" ").join("_").to_sym } #convert the categories from string to symbols
		
		hash = Hash[array.collect{|category| [category, Hash.new]}]
		hash
	end

end