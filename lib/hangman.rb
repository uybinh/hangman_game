class Hangman
  attr_reader :incomplete_word

  def initialize(keyword)
    @keyword = keyword
    @incomplete_word = Array.new(keyword.length, "_")
  end

  def win?
    @keyword == @incomplete_word.join
  end
end