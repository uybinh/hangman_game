require "./lib/keyword.rb"

puts "Welcome to Hangman game!"
newkey = Keyword.generate_keyword
puts newkey.content
