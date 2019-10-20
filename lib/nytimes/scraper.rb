module NYTBestsellers
  class Scraper
    def self.get_page
      @@page ||= Mechanize.new.get("http://www.nytimes.com/books/best-sellers/")
    end

    def self.make_genres
      get_page.css("section h2").each do |category|
        NYTBestsellers::Genre.new({
          name: category.css("a").text.strip, 
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
        book_genre = page.css("section h2")[0].text
        books = page.css("ol")[0].css("li article a")

        books.each do |book|
          if book.css("p")[1] != nil && book.css("p")[1].attribute("itemprop").value == "author"
            NYTBestsellers::Book.new({
              genre: book_genre,
              title: book.css("h3").text.split.collect(&:capitalize).join(" "),
              author: book.css("p")[1].text.split.delete_if{|x| x == "by"}.join(" "),
              publisher: book.css("p")[2].text,
              wol: book.css("p")[0].text,
              summary: book.css("p")[3].text
            })
          end
        end
      end
    end

    def self.get_date
      get_page.css("div.date-range").text.strip
    end
  end  
end      
