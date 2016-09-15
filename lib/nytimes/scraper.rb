class NYTBestsellers::Scraper

  def self.get_page
    agent = Mechanize.new
    page = agent.get("http://www.nytimes.com/books/best-sellers/")
  end

  def self.scrape_genres
    self.get_page.css("section.subcategory")
  end

  def self.make_genres
    scrape_genres.each do |category|
      NYTBestsellers::Genre.new(
        category.css("a.subcategory-heading-link").text.strip,
        "http://www.nytimes.com#{category.css("a").attr("href").text}"
        )
    end
  end

  def self.get_genre_pages
    agent = Mechanize.new
    NYTBestsellers::Genre.all.collect do |genre|
      page = agent.get("#{genre.url}")
    end
  end

  def self.make_books
    get_genre_pages.each do |page|
      books = page.css("div.book-body")

      books.each do |book|
        NYTBestsellers::Book.new(
          page.css("h1").text.split(/\s-\s/)[0].strip, #genre
          book.css("h2.title").text.split.collect(&:capitalize).join(" "),
          book.css("p.author").text.split.delete_if{|x| x == "by"}.join(" "),
          book.css("p.publisher").text,
          book.css("p.freshness").text,
          book.css("p.description").text
          )
      end
    end
  end

  def self.run
    NYTBestsellers::Book.all.each do |book|
      puts "1. #{book.title}"
    end


  end


  # def self.scrape_bestsellers_by_genre
  #   array = Array.new
  #   doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/"))
  #   categories = doc.css(".bookCategory")

  #   categories.each do |category|
  #     hash = Hash.new
  #     hash[:genre] = category.css("h3 a").text.split.collect(&:capitalize).join(' ')
  #     hash[:url] = category.css("a").attr("href").text
  #     array << hash
  #   end
      
  #   array.delete_if {|hash| hash[:genre] == "" || hash[:genre] == "Combined Print &amp; E-book Fiction" || hash[:genre] == "Combined Print &amp; E-book Nonfiction"}

  #   #for some reason it wouldn't let me do ("h2 a") in the above 'each' iterator
  #   pb_non = doc.css(".story")[7]
  #   hash_2 = Hash.new
  #   hash_2[:genre] = pb_non.css("h2").text.split.collect(&:capitalize).join(' ')
  #   hash_2[:url] = pb_non.css("a").attr("href").text
  #   array << hash_2
  # end

  # def self.scrape_book_attributes
  #   array = Array.new

  #   NYTBestsellers::Genre.all.each do |genre|
  #     doc = Nokogiri::HTML(open(genre.url))
  #     details = doc.css(".bookDetails")

  #     details.each do |attribute|
  #       hash = Hash.new
  #       hash[:genre] = doc.css(".bestSellersHeadingLg").text

  #       title = attribute.css(".bookName").text.split.collect(&:capitalize) 
  #       hash[:title] =  title.collect! {|x| x == title.last ? x.gsub(",", "") : x}.join(" ")

  #       hash[:author] = attribute.css(".summary").text.match(/by.*\.\s\(\w/).to_s.gsub(/\.\s\(\w/, "").gsub("by ","")
  #       hash[:publisher] = attribute.css(".summary").text.match(/\(.*\)/).to_s.gsub(/[(.)]/, "")
  #       hash[:summary] = attribute.css(".summary").text.match(/\).*\./).to_s.gsub(") ", "")
        
  #       if hash[:genre] == "Paperback Trade Fiction" || hash[:genre] == "Paperback Nonfiction"
  #         hash[:wol] = attribute.css(".weeklyPosition").text
  #       else
  #         hash[:wol] = attribute.css(".weeklyPosition")[1].text #other genres had two classes of the same name 'weeklyposition'
  #       end
  #       array << hash
  #     end
  #   end
  #   array
  # end
  

  # def self.scrape_current_date
  #   doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/"))
  #   current_date = doc.css(".element1 p").text
  # end

  # def self.scrape_minor_genres
  #   array = Array.new
  #   doc = Nokogiri::HTML(open("http://www.nytimes.com/best-sellers-books/"))
  #   exclude = [0, 1, 2, 3, 8, 11]

  #   categories = doc.css(".bColumn .story").css("h2").reject.with_index{|x, index| exclude.include?(index)}
  #   categories.each do |category|
  #     hash = Hash.new
  #     hash[:genre] = category.text
  #     hash[:url] = category.css("a").attr("href").text
  #     array << hash
  #   end
  #   array
  # end

  # def self.scrape_minor_genre_books
  #   array = Array.new

  #   NYTBestsellers::OtherGenre.all.each do |genre|
  #     doc = Nokogiri::HTML(open(genre.url))
  #     details = doc.css(".bookDetails")

  #     details.each do |attribute|
  #       hash = Hash.new

  #       title = attribute.css(".bookName").text.split.collect(&:capitalize)
  #       hash[:title] =  title.collect! {|x| x == title.last ? x.gsub(",", "") : x}.join(" ")
  #       hash[:genre] = doc.css(".bestSellersHeadingLg").text
  #       hash[:author] = attribute.css(".summary").text.match(/by.*\.\s\(\w/).to_s.gsub(/\.\s\(\w/, "").gsub("by ", "")
  #       hash[:publisher] = attribute.css(".summary").text.match(/\(.*\)/).to_s.gsub(/[(.)]/, "")
  #       hash[:summary] = attribute.css(".summary").text.match(/\).*\./).to_s.gsub(") ", "")
  #       hash[:wol] = attribute.css(".weeklyPosition").text
  #       array << hash
  #     end
  #   end
  #   array
  # end

end      
