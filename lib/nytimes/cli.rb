class NYTBestsellers::CLI

  def call 
    NYTBestsellers::Scraper.make_genres
    NYTBestsellers::Scraper.make_books
    puts ""
    puts "Welcome to the New York Times Bestsellers List".blue.bold
    NYTBestsellers::Scraper.get_date
    # run

  end

  def run
    puts "-------------------"
    puts ""
    puts "NYT Bestsellers - Week of #{NYTBestsellers::Scraper.scrape_current_date}".bold.blue
    puts ""
    puts "Here are the top categories:"
    puts ""
    display_genres(major_genres)
    puts "5 - See More"
    puts ""
    response = ""

    while response != "exit"
    puts "Select a category by number:" + "[exit]".light_red
    response = gets.strip

      if (1..4).to_a.include?(response.to_i)
        display_category(response, major_genres)
      elsif response.to_i == 5
        display_minor_genres
      elsif response == "exit"
        puts "Goodbye!~".bold.red
        puts ""
        exit
      end
    end
  end

  def display_genres(genre_class)
    genre_class.all.each_with_index do |genre, index|
      puts "#{index+1} - #{genre.name}" 
    end
  end

  def display_minor_genres
    puts ""
    puts "****----Additional Categories----****".bold.blue
    puts ""
    display_genres(minor_genres)
    puts ""
    answer = ""

    while answer != "exit"
      puts "Select a category by number:" + "[back][exit]".light_red
      answer = gets.strip

      if answer == "back"
        run
      elsif answer == "exit"
        puts "Goodbye!~".bold.red
        puts ""
        exit
      elsif answer.to_i <= minor_genres_count
        display_category(answer, minor_genres)
      end
    end
  end

  def display_category(response, genre_class)
    genre = genre_class.find_by_num(response.to_i)
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

    puts ""
    puts "^ refers to the current position on the bestseller's list"
    puts ""
    puts "Select a book by rank number to get more info:" + "[back][exit]".light_red
    puts ""
    book_input = gets.strip 
    puts ""
    display_book_info(response, book_input, genre_class)

    if book_input == "back" && genre_class == major_genres
      run
    elsif book_input == "back" && genre_class == minor_genres
      display_minor_genres
    elsif book_input == "exit"
      puts "Goodbye!~".bold.red
      puts ""
      exit
    end
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