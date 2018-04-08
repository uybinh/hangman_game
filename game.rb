require "./lib/keyword.rb"
require "./lib/hangman.rb"
require "./lib/player.rb"
require "yaml"

def update_game_state(hangman, player, guess)
  hangman.update_incomplete_word(guess)
  update_player_state(hangman, player, guess)
end

def update_player_state(hangman, player, guess)
  player.lives -= 1 if !hangman.guess_right?(guess)
end

def create_yaml(hangman, player)
  yaml = YAML.dump({
    hangman: hangman,
    player: player
  })
end

def create_saved_file(file_name, content)
  file = File.open(file_name, 'w')
  file.write(content)
  file.close
end

def save_game(hangman, player)
  yaml = create_yaml(hangman, player)
  create_saved_file("save_game.yaml", yaml)
end

def load_game
  YAML.load(File.read("save_game.yaml"))
end

while true
  puts "".center(50,'-')
  puts " Welcome to Hangman game! ".center(50, "*")
  puts "".center(50,'-')
  puts "Press any key to start the game."
  puts "Press q to exit game."
  input = gets.chomp
  break if input.downcase == 'q'

  keyword = Keyword.generate_keyword
  hangman = Hangman.new(keyword.content)
  puts "Please enter player name:"
  player_name = gets.chomp
  player = Player.new(player_name)
  puts "GAME START!!"
  sleep 0.5
  system("clear")

  while true
    guess = ''
    loop do
      hangman.show_incomplete_word
      puts "1. End game"
      puts "2. Save game"
      puts "3. Load game"
      puts ". or any other charators to guess"
      print "Please enter an option: "
      guess = gets.chomp
      case guess
      when '1'
        exit
      when '2'
        save_game(hangman, player)
        puts "Game saved!!"
      when '3'
        game_object = load_game
        hangman = game_object[:hangman]
        player = game_object[:player]
        puts "Game loaded!!"
      when /^[a-zA-Z]$/
        break
      end
    end
    update_game_state(hangman, player, guess)
    print "Lives remain: "
    puts player.lives

    if hangman.lose?(player)
      puts "".center(50,"-")
      puts " You lose! Let's try again #{player.name}! ".center(50,"*")
      puts "".center(50,"-")
      break
    end

    if hangman.win?
      puts "".center(50,"-")
      puts " You win, #{player.name}! ".center(50,"*")
      puts "".center(50,"-")
      break
    end
  end

  puts "Press any key to quit the game."
  puts "Press r to play again"
  input = gets.chomp
  next if input == 'r'
  exit
end