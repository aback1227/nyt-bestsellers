# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nytimes/version'

Gem::Specification.new do |spec|
  spec.name          = "nyt-bestsellers"
  spec.date          = '2016-03-21'
  spec.version       = '0.1.2'
  spec.authors       = ["Amy Back"]
  spec.email         = "aback1227@gmail.com"
  spec.description   = "New York Times Bestsellers List"
  spec.summary       = "Lists books by genre from the NYT Bestsellers List"
  spec.homepage      = "https://github.com/aback1227/nyt-bestsellers"
  spec.license       = "MIT"

  spec.files         = ["lib/nyt_bestsellers.rb", "lib/nytimes/book.rb", "lib/nytimes/cli.rb", "lib/nytimes/scraper.rb", "config/environment.rb", "lib/nytimes/other_books.rb", "lib/nytimes/other_genres.rb", "lib/nytimes/genre.rb"]
  spec.executables   = ["nyt-bestsellers"]
  spec.require_paths = ["lib", "lib/nytimes"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "colorize"
end
