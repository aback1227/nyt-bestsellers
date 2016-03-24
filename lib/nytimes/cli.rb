class NYTBestsellers::CLI

	def call 
	  make_genres
	  make_books_with_attributes
	  # puts ""
	  # puts "Welcome to the New York Times Bestsellers List"
	  # puts ""
	  # run
	  NYTBestsellers::Scraper.scrape_price_rating
	end

	def run
	  puts ""
      puts "Here are the top categories:"
	  puts ""
	  display_genres
	  puts ""
	  response = ""
	  while response != "exit"

		  puts "Select a category by number or 'exit':"
		  nums =* (1..5)
		  response = gets.strip 

		  if nums.include?(response.to_i)
		    display_category(response.to_i)
		    puts ""
		    puts "Select a book by rank number to get more info or go 'back':"
		    book_input = gets.strip
		    genre = NYTBestsellers::Genre.find_by_num(response.to_i)
		    if (name = genre.books[book_input.to_i-1]) == (book = NYTBestsellers::Book.find_by_title(name)).title
		    	display_book_info(book)
		    elsif book_input == "back"
		      run
		    end
		  elsif response == "exit"
		    puts "Goodbye!~"
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
	    puts "#{index+1}. #{genre.name}"
	  end
	  puts "5. More categories..."
	end

	def display_category(num)
	  genre = NYTBestsellers::Genre.find_by_num(num)
	  puts ""
	  puts "****----#{genre.name.upcase}----****"
	  puts ""
	  puts "--------------------------------------------------------------"
	  puts " Rank^ |  Weeks on List  |    Title"
	  puts "--------------------------------------------------------------"
	  genre.books.each_with_index do |book, index|
	  	x = NYTBestsellers::Book.find_by_title(book)
	  	x.wol << " " if x.wol.length == 1  #adds spacing
	    puts "   #{index+1}   |        #{x.wol}       | #{book}"      
	  end
	  puts ""
	  puts "^ refers to the current position on the bestseller's list"
	  puts ""
	end

	def display_book_info(book)
		puts "****----#{book.title}----****"
		puts ""
		puts "Weeks On Bestseller: #{book.wol}"
		puts "Author: #{book.author}"
		puts "Publisher: #{book.publisher}"
		puts "Genre: #{book.genre.name}"
		puts ""
		puts "---------Summary---------"
		puts "#{book.summary}"
		puts ""
	end

end