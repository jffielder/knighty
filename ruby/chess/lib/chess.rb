#build board
# 8x8 grid

#describe pieces 

#load pieces


#pieces hold all moves and attacks available, if a piece is given a move that is not in its moveset 

require_relative 'Board'




def s_to_array(input)
  a = input.split(",")
  b = []
  c = input.split()

  a.each do |i|
    b << i.to_i
  end

  return nil if b.size != 2

  return b


end


def start_game

  board = Board.new

  

  puts "     Welcome to Chess"
  puts ""

  until game_over? do

    board.draw

    puts ""
    puts "#{board.player} turn"
    puts "select piece [x,y]"

    print ": "
    start_pos = gets.chomp

    start_pos = s_to_array(start_pos)

    board.draw

    puts ""
    puts "#{board.spaces[start_pos].type} #{start_pos} move to?"
    puts ""
    print "[x,y]: "

    end_pos = gets.chomp

    end_pos = s_to_array(end_pos)

    board.move_piece( start_pos , end_pos )

    board.draw

    board.switch_player



  end


end

def game_over?
  return false
end

#start_game

=begin

board = Board.new
board.draw
puts "white move: #{board.move_piece([0,1], [0,3])}"
board.draw

board.switch_player
puts "black move: #{board.move_piece([1,6], [1,4])}"
board.draw

board.switch_player
puts "white move: #{board.move_piece([0,3], [1,4])}"
board.draw
  
=end

