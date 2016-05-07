class NYTBestsellers::OtherBook < NYTBestsellers::Book

  def initialize(attribute_hash)
    attribute_hash.each do |key, value| 
      if key == :genre
        genre_name = value
        genre = NYTBestsellers::OtherGenre.find_by_name(genre_name)
        self.send(("genre="), genre)
      else
        self.send(("#{key}="), value)
      end
    end
    @@all << self
  end
  
end