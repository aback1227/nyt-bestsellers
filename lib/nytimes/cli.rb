class NYTBestsellers::CLI

	def call 
	  make_genres
	  add_attributes_to_books
	end

	def make_genres
	  genres_array = NYTBestsellers::Scraper.scrape_bestsellers_by_genre
	  NYTBestsellers::Genre.new_from_collection(genres_array)
	end

	# def display_bestsellers
	#   NYTBestsellers::Genre.all.each do |genre|
	#   	puts "#{genre.book_title}"
	#   end
	# end

	def add_attributes_to_books
	  attributes_array = NYTBestsellers::Scraper.scrape_book_attributes
	  NYTBestsellers::Book.new_from_collection(attributes_array)
	end


end