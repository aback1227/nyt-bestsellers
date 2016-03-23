class NYTBestsellers::Genre

	attr_accessor :genre, :url
	@@all = []

	def initialize(genre_hash)
		genre_hash.each {|key, value| self.send(("#{key}="), value)}
		@@all << self
	end

	def self.create_from_collection(genres_array)
	  # genres_array.each do |genre_hash|
	  # 	genre_hash.each do |key, value|
	  # 		binding.pry
	  # 	end
	  # 	self.new(genre_hash)
	  # end
	end

	def self.all
		@@all
	end

end