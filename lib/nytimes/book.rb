class NYTBestsellers::Book

	attr_accessor :genre, :title, :author, :publisher, :wol, :summary, :price

	@@all = []

	def initialize(attribute_hash)

	end

	def self.all
	  @@all
	end

	def self.new_from_collection(attributes_array)
		attributes_array.each do |attribute_hash|
			self.new(attribute_hash)
		end
	end

	def add_book_attributes
	end

	def genre
	end



	
end