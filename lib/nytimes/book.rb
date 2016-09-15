class NYTBestsellers::Book

  attr_accessor :genre, :title, :author, :publisher, :wol, :summary

  @@all = []

  def initialize(genre=nil, title=nil, author=nil, publisher=nil, wol=nil, summary=nil)
    @genre = NYTBestsellers::Genre.find_by_name(genre)
    @title = title
    @author = author
    @publisher = publisher
    @wol = wol
    @summary = summary
    @@all << self if !wol.empty? || !summary.empty?
  end
  
  # def initialize(attribute_hash)
  #   attribute_hash.each do |key, value| 
  #     if key == :genre
  #       genre_name = value
  #       genre = NYTBestsellers::Genre.find_by_name(genre_name)
  #       self.send(("genre="), genre)
  #     else
  #       self.send(("#{key}="), value)
  #     end
  #   end
  #   @@all << self
  # end

  def self.all
    @@all
  end

  # def self.new_book_attributes(attributes_array)
  #   attributes_array.each do |attribute_hash|
  #     self.new(attribute_hash)
  #   end
  # end

  def self.find_by_title(name)
    self.all.find do |book| 
      if name == book.title
        book
      end
    end
  end

  def genre=(genre)
    @genre = genre
    genre.books << self unless genre.books.include?(self)
  end
  
end