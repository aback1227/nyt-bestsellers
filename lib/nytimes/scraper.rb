module NYTBestsellers
  class Scraper
    def self.get_page
      @@page ||= Mechanize.new.get("http://www.nytimes.com/books/best-sellers/")
    end

    def self.make_genres
      get_page.css("section.subcategory").each do |category|
        NYTBestsellers::Genre.new({
          name: category.css("a.subcategory-heading-link").text.strip, 
          url: "http://www.nytimes.com#{category.css("a").attr("href").text}"
        })
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
          NYTBestsellers::Book.new({
            genre: page.css("h1").text.split(/\s-\s/)[0].strip, #genre
            title: book.css("h2.title").text.split.collect(&:capitalize).join(" "),
            author: book.css("p.author").text.split.delete_if{|x| x == "by"}.join(" "),
            publisher: book.css("p.publisher").text,
            wol: book.css("p.freshness").text,
            summary: book.css("p.description").text
          })
        end
      end
    end

    def self.get_date
      get_page.css("div.date-range").text.strip
    end
  end  
end      
