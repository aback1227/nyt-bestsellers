class NYTBestsellers::CLI

	def call 
	  make_genres
	  make_books_with_attributes
	  puts "Welcome to the New York Times Bestsellers List"
	  puts "Here are the categories:"
	  display_genres
	end

	def make_genres
	  genres_array = NYTBestsellers::Scraper.scrape_bestsellers_by_genre
	  NYTBestsellers::Genre.new_from_collection(genres_array)
	end

	def make_books_with_attributes
	  attributes_array = NYTBestsellers::Scraper.scrape_book_attributes
	  NYTBestsellers::Book.new_book_attributes(attributes_array)
	end

	def display_genres
	  NYTBestsellers::Genre.all.each_with_index do |genre, index|
	    puts "#{index+1}. #{genre.name}"
	  end
	end

	def books_genre
	  NYTBestsellers::Book.all.each do |x|
	  	x.genre
	  end
	end
end