class NYTBestsellers::Genre

	attr_accessor :name, :url

	@@all = []

	def initialize(genres_hash)
	  @books = []
	  genres_hash.each do |key, value| 
	  	if key == :books
	  	  value.each do |title|
	  	  	NYTBestsellers::Book.find_by_title(title)
	  	  	@books << title
	  	  end
	  	elsif key == :genre
	  	self.send("name=", value)
	    else 
	    self.send(("#{key}="), value)
	  	end
	  end
	  @@all << self
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

	def self.find_by_name(genre_name)
	  self.all.find {|x| x.name == genre_name}
	end

	def self.find_by_num(num_input)
	  self.all[num_input.to_i-1]
 	end

end