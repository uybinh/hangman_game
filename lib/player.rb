class Player
  attr_accessor :name, :lives

  def initialize(name)
    @name = name
    @lives = 10
  end

  def valid_guess?(guess)
    guess.match?(/^[a-zA-Z]$/)
  end

end