class NYTBestsellers::CLI

	def call 
	  make_genres
	  NYTBestsellers::Genre.all
	end

	def make_genres
	  genres_array = NYTBestsellers::Scraper.scrape_bestsellers_by_genre
	  NYTBestsellers::Genre.create_from_collection(genres_array)
	end



end