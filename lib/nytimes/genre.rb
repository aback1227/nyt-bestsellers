class NYTBestsellers::Genre

  attr_accessor :name, :url

  @@all = []

  def initialize(hash = {})
    hash.each do |key, value|
      self.send("#{key}=", value)
    end  
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