class NYTBestsellers::CLI

	def call 
	  make_genres
	  make_books_with_attributes
	  puts ""
	  puts "Welcome to the New York Times Bestsellers List".blue.bold
	  run
	  # NYTBestsellers::Scraper.scrape_price_rating
	end

	def run
	  puts "-------------------"
	  puts ""
	  puts "NYT Bestsellers - Week of #{NYTBestsellers::Scraper.scrape_current_date}".bold.blue
	  puts ""
      puts "Here are the top categories:"
	  puts ""
	  display_genres
	  puts ""
	  response = ""
	  while response != "exit"

		  puts "Select a category by number:" + "[back][exit]".light_red
		  nums =* (1..5)
		  response = gets.strip

		  if nums.include?(response.to_i)
		    display_category(response)
		    # genre = NYTBestsellers::Genre.find_by_num(response.to_i)
		    # if (name = genre.books[book_input.to_i-1]) == (book = NYTBestsellers::Book.find_by_title(name)).title
		    # if nums.include?(book_input.to_i)
		    #   display_book_info(response, book_input)
		    # elsif book_input == "back"
		    #   run
		    # elsif book_input == "exit"
		    #   exit
		    # end
		  elsif response == "back"
		  	run
		  elsif response == "exit"
		    puts "Goodbye!~".bold.red
		    puts ""
		    exit
		  end
      end
	end

	def make_genres
	  genres_array = NYTBestsellers::Scraper.scrape_bestsellers_by_genre
	  NYTBestsellers::Genre.new_from_collection(genres_array)
	end

	def make_books_with_attributes
	  attributes_array = NYTBestsellers::Scraper.scrape_book_attributes
	  NYTBestsellers::Book.new_book_attributes(attributes_array)
	end

	def display_genres
	  NYTBestsellers::Genre.all.each_with_index do |genre, index|
	    puts "#{index+1} - #{genre.name}"
	  end
	  puts "5 - More categories..."
	end

	def display_category(response)
	  genre = NYTBestsellers::Genre.find_by_num(response.to_i)
	  puts ""
	  puts "****----#{genre.name.upcase}----****".blue.bold
	  puts ""
	  puts " Rank^ |  Weeks on List  |  Title"
	  puts "---------------------------------------------------------"
	  genre.books.each_with_index do |book, index|
	  	x = NYTBestsellers::Book.find_by_title(book)
	  	x.wol << " " if x.wol.length == 1  #adds spacing
	    puts "   #{index+1}   |        #{x.wol}       | #{book}"      
	  end
	  puts ""
	  puts "^ refers to the current position on the bestseller's list"
	  puts ""
	  puts "Select a book by rank number to get more info:" + "[back][exit]".light_red
	  puts ""
	  nums =* (1..5)
	  book_input = gets.strip 
	  puts ""
	  if nums.include?(book_input.to_i)
		display_book_info(response, book_input)
	  elsif book_input == "back"
	    run
	  elsif book_input == "exit"
	  	puts "Goodbye!~".bold.red
		puts ""
		exit
	  end
	end

	def display_book_info(response, book_input)
		genre = NYTBestsellers::Genre.find_by_num(response.to_i)
		if (name = genre.books[book_input.to_i-1]) == (book = NYTBestsellers::Book.find_by_title(name)).title
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
			   display_category(response)
			elsif input == "exit"
				puts "Goodbye!~".bold.red
		        puts ""
				exit
			elsif input == "menu"
				run
				puts ""
			end
		end

	end

end