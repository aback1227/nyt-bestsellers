# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'nytimes/version'

Gem::Specification.new do |spec|
  spec.name          = "nytimes-bestsellers"
  spec.date          = '2016-03-21'
  spec.version       = '0.0.0'
  spec.authors       = ["Amy Back"]
  spec.email         = "aback1227@gmail.com"
  spec.summary       = "Details New York Times bestsellers list"
  spec.homepage      = "https://github.com/aback1227/nytimes-bestsellers"
  spec.license       = "MIT"
  spec.files         = ["lib/nytimes_bestsellers", "lib/nytimes/book.rb", "lib/nytimes/cli.rb", "lib/nytimes/scraper.rb", "config/environment.rb", "lib/nytimes/other_books.rb", "lib/nytimes/other_genres.rb"]
  spec.executables   = ["nytimes-bestsellers"]
  spec.require_paths = ["lib", "lib/nytimes"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "nokogiri", ">= 0"
  spec.add_development_dependency "pry", ">= 0"
  spec.add_development_dependency "colorize", ">= 0"
end
