class Hangman
  attr_reader :incomplete_word, :keyword

  def initialize(keyword)
    @keyword = keyword.split('')
    @incomplete_word = Array.new(keyword.length, "_")
  end

  def show_incomplete_word
    puts @incomplete_word.join(" ")
  end

  def guess_right?(guess)
    @keyword.include?(guess)
  end

  def update_incomplete_word(guess)
    if guess_right?(guess)
      @keyword.each_with_index do |char, index|
        @incomplete_word[index] = guess if char == guess
      end
    end
    @incomplete_word
  end

  def lose?(player)
    player.lives <= 0
  end

  def win?
    @keyword == @incomplete_word
  end

end