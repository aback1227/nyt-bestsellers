class NYTBestsellers::Genre

  attr_accessor :name, :url

  @@all = []

  def initialize(name=nil, url=nil)
    @name = name
    @url = url
    @@all << self
    @books = []
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