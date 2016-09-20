class NYTBestsellers::CLI

  def call 
    NYTBestsellers::Scraper.make_genres
    NYTBestsellers::Scraper.make_books
    puts ""
    puts "Welcome to the New York Times Bestsellers List".blue.bold
    run
  end

  def run
    puts "-------------------"
    puts ""
    puts "NYT Bestsellers - Week of #{NYTBestsellers::Scraper.get_date}".bold.blue
    puts "(Lists are published early online.)".bold.blue
    puts ""
    puts "Here are the top categories:"
    puts ""
    display_genres

    response = ""
    while response != "exit"
      puts "Select a category by number:" + "[exit]".light_red
      response = gets.strip
      if (1..5).to_a.include?(response.to_i)
        genre_books(response.to_i)
      elsif response == "exit"
        puts "Goodbye!~".bold.red
        puts ""
        exit
      end
    end
  end

  def display_genres
    NYTBestsellers::Genre.all.each_with_index do |genre, index|
      puts "#{index+1} - #{genre.name}" 
    end
  end

  def genre_books(response)
    genre = NYTBestsellers::Genre.find_by_num(response)
    puts ""
    puts "****----#{genre.name.upcase}----****".blue.bold
    puts ""
    puts "  Rank^     Title"
    puts "  -----     -----"
    
    genre.books.each_with_index do |book, index|
      rank_s = "   #{index+1}   "
      rank_s << " " if (0..8).include?(index)

      title_s = "    #{book.title}"
      puts rank_s + title_s  
    end

    # puts ""
    # puts "^ refers to the current position on the bestseller's list"
    # puts ""
    # puts "Select a book by rank number to get more info:" + "[back][exit]".light_red
    # puts ""
    # book_input = gets.strip 
    # puts ""
    # display_book_info(response, book_input, genre_class)

    # if book_input == "back" && genre_class == major_genres
    #   run
    # elsif book_input == "back" && genre_class == minor_genres
    #   display_minor_genres
    # elsif book_input == "exit"
    #   puts "Goodbye!~".bold.red
    #   puts ""
    #   exit
    # end
  end

  def display_book_info(response, book_input, genre_class)
    genre = genre_class.find_by_num(response.to_i)

    genre.books.each_with_index do |book, index|
      if book_input.to_i == index+1
        puts "****----#{book.title}----****".blue.bold
        puts ""
        puts "Weeks On Bestseller:".bold + " #{book.wol}"
        puts "Author:".bold + " #{book.author}"
        puts "Publisher:".bold + " #{book.publisher}"
        puts "Genre:".bold + " #{book.genre.name}"
        puts ""
        puts "---------Summary---------".bold
        puts "#{book.summary}"
        puts ""
        puts "[back][menu][exit]".light_red
        puts ""
        input = gets.strip
        puts ""

        if input == "back"
          display_category(response, genre_class)
        elsif input == "exit"
          puts "Goodbye!~".bold.red
          puts ""
          exit
        elsif input == "menu"
          run
          puts ""
        end #second if
      end #first if
    end #each
  end

end