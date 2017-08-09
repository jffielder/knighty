=begin

new game


load 1.img
display underscores
display letters tried
form input


=end


require './hangman'
require 'sinatra'
require 'sinatra/reloader'

game = Game.new

get '/' do 

    if !params[:newgame].nil? 
      game = Game.new
      error = ""
      params[:guess] = nil
    end

    if is_letter?(params[:guess]) 
      
      game.add_attempt(params[:guess])
      game.update_blanks
      game.update_strikes

      error = ""
    else
      error = "Error, invalid format entered"
    end

    if game.won?
      message = "Congratulations! You Win!"
      
    elsif game.lost?

      message = "You Lose, Try Again."
    else
      message = ""
    end

    puts message

  erb :index, :locals => {game: game, error: error, message: message}
end
