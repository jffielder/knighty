require './game.rb'

require 'yaml'

def menu
  puts "1. New Game"
  puts "2. Load Game"
  puts "0. Exit"

  menu_options = [1,2,0]

  option_selected = gets.chomp.to_i

  while !(menu_options.include? option_selected)
    puts "\n\tInvalid Selection, Try Again"
    option_selected = gets.chomp.to_i
  end

  return option_selected
  
end


def controller(option)
  #1 set up new game and begin game

  #2 load last save and begin game

  #3 display all saved games and load and begin game
  puts `clear`

  if option.eql? 1
    game1 = Game.new

    continue_game(game1)
  
  elsif option.eql? 2

    continue_game(load_game)
  end

end#controller





def load_game
  puts "Enter game name to load:"

  puts `ls *yml`

  filename = gets.chomp

  filename << ".yml"

  serialized = File.read(filename)

  game = YAML.load(serialized)

  return game
  
end

def save(game)
  #YAML push
  puts "Enter save game name:"

  puts `ls *yml`

  filename = gets.chomp

  filename << ".yml"

  File.open(filename, "w") {|f| f.write(game.to_yaml) }


end

#takes string and returns true if first char is a..z
def is_letter?(guess = "")

  guess = "" if guess.nil?


  guess = guess.downcase
  
  if ('a'..'z').include? guess[0]
    return true
  else
    return false
  end

end

def continue_game(game)
    until game.over? || game.won?

      game.update_blanks

      game.update_strikes
      
      game.draw

      guess = get_guess

      if guess == "save"
        save(game)
        puts "\n\n...\n\nSaved. Returning to menu\n\n"
        controller(menu)
        break
      elsif guess == "exit"
        controller(menu)
        break
      end        

      game.add_attempt(guess)

      game.update_blanks

      game.update_strikes

      game.draw

    end
    
  end


def start_game
puts "\n\n\n\tWelcome To Hangman\n\n"

controller(menu)

end
