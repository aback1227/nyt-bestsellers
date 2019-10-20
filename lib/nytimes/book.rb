module NYTBestsellers
  class Book
    attr_accessor :genre, :title, :author, :publisher, :wol, :summary
    @@all = []

    def initialize(hash = {})
      hash.each do |key, value|
        self.send("#{key}=", value)
      end
      @genre = NYTBestsellers::Genre.find_by_name(hash[:genre])
      if !wol.empty? || !summary.empty?
        @genre.books << self 
        @@all << self
      end
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
end