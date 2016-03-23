require 'pry'
class NYTBestsellers::Genre

	attr_accessor :genre, :url, :books

	@@all = []

	def initialize(genres_hash)
	  genres_hash.each {|key, value| self.send(("#{key}="), value)}
	  @@all << self
	  @books = []
	end

	def self.new_from_collection(genres_array)
	  genres_array.each do |genres_hash|
	    self.new(genres_hash)
	  end
	end

	def self.all 
	  @@all
	end

	def books
	  @books
	end

end