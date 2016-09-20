class NYTBestsellers::Scraper

  def self.get_page
    agent = Mechanize.new
    page = agent.get("http://www.nytimes.com/books/best-sellers/")
  end

  def self.scrape_genres
    get_page.css("section.subcategory")
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

  def self.get_date
    get_page.css("div.date-range").text.strip
  end
  
end      
