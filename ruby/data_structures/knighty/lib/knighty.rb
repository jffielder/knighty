class Node
  attr_accessor :one, :two, :four, :five, :seven, :eight, :ten, :eleven

end


#lays out squares by what each square contains a symbol

# **update board by assigning square to equal piece (updates are tracked by moves)
class Board
  attr_accessor :squares, :moves #squares = [0,0] .. [7,7]
  attr_reader :destination

  def initialize(origin, dest)
    @moves = 0
    @destination = dest
    x = origin[0]
    y = origin[1]
    @squares = {[x,y] => :knight}
  end

  def move_piece(old_loc, new_loc, piece)
    @squares = {old_loc => nil, new_loc => piece}
    @moves = @moves + 1
  end

end

class Piece
  attr_accessor :loc

  def initialize(origin)
    @loc = origin    
  end

  def move(new_loc)
    @loc = new_loc
  end

end


class Move
  attr_accessor :parent_Move, :loc

  def initialize(loc, parent_move = nil)
    @parent_move = parent_move
    @loc = loc
  end
end

#takes loc 
def valid_knight_moves_from(move_node)
  end_locs = []

  loc = move_node.loc
  previous_loc = move_node.parent_move.loc
  moves = [previous_move.loc]

  until previous_loc.nil? do
    

  x = loc[0]
  y = loc[1]

  possible_end_locs =
  [ [x+1, y+2],
    [x+1, y-2],
    [x-1, y+2],
    [x-1, y-2],
    [x+2, y+1],
    [x+2, y-1],
    [x-2, y+1],
    [x-2, y-1] ]

    end_locs = possible_end_locs.select do |this_loc|
      (this_loc[0].between?(0,7) &
      this_loc[1].between?(0,7)) & !this_loc.member?(moves)
    end

    end_moves = end_locs.map do |this_end_loc| Move.new(this_end_loc, loc) end


end


def knight_moves( start, dest )

  dest_reached = false


  #QUEUE
  unvisited_moves = Queue.new
  visited_moves = Queue.new

  #dealing with Move objects (parent_loc and loc), root move has no parent_loc
  initial_move_list = valid_knight_moves_from(start,moves)

  initial_move_list.find |move| do move.loc == dest end

  #initial test
  if initial_move_list.include?(dest)
    return initial_move_list.find do |move| move == dest end
  end

  #initial queue load

  initial_move_list.map do |move| unvisited_moves.push(move) end


  #traversal
  until dest_reached do
    testing_move = Move.new(unvisited_moves.pop,
    dest_reached = true if testing_move.eql?(dest)
    valid_knight_moves_from(unvisited_moves.pop,moves).map do |new_move| unvisited_moves.push(new_move) end
  end


  return moves << current_level_children.find do |node| node == dest end if current_level_children.include?(dest)


end


#test
puts "#{knight_moves([0,0], [0,2])}"