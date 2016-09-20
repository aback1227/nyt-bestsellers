# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nytimes/version'

Gem::Specification.new do |spec|
  spec.name          = "nyt-bestsellers"
  spec.date          = '2016-09-19'
  spec.version       = '0.0.1'
  spec.authors       = ["Amy Back"]
  spec.email         = "aback1227@gmail.com"
  spec.description   = "A CLI based on the New York Times Bestsellers List. Provides list of top-selling books by genre."
  spec.summary       = "Lists books by genre from the NYT Bestsellers List"
  spec.homepage      = "https://github.com/aback1227/nyt-bestsellers"
  spec.license       = "MIT"

  spec.files         = ["lib/nyt_bestsellers.rb", "lib/nytimes/book.rb", "lib/nytimes/cli.rb", "lib/nytimes/scraper.rb", "config/environment.rb", "lib/nytimes/genre.rb"]
  spec.executables   = ["nyt-bestsellers"]
  spec.require_paths = ["lib", "lib/nytimes"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", '~> 0'
  spec.add_development_dependency "pry",  '~> 0'
  spec.add_development_dependency "colorize", '~> 0'
  spec.add_development_dependency "mechanize", '~> 0'
end
