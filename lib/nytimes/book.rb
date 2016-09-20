class NYTBestsellers::Book

  attr_accessor :genre, :title, :author, :publisher, :wol, :summary

  @@all = []

  def initialize(genre=nil, title=nil, author=nil, publisher=nil, wol=nil, summary=nil)
    @genre = NYTBestsellers::Genre.find_by_name(genre)
    @genre.books << self unless @genre.books.include?(self)
    @title = title
    @author = author
    @publisher = publisher
    @wol = wol
    @summary = summary
    @@all << self if !wol.empty? || !summary.empty?
  end

  def self.all
    @@all
  end

  def self.find_by_title(name)
    self.all.find do |book| 
      if name == book.title
        book
      end
    end
  end
  
end