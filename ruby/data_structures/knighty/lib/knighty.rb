
########### independant code **

class Move
  attr_accessor :parent_move, :loc

  def initialize(loc, parent_move = nil)
    @parent_move = parent_move
    @loc = loc
  end
end

#takes move obj and returns array of move obj
def available_knight_moves_from(move_node)
  
  moves = [move_node.loc]
  
  temp_node = move_node

  until temp_node.parent_move.nil? do
  
    temp_node = temp_node.parent_move
    
    moves.push(temp_node.loc)
    
  end
    
  x = move_node.loc[0]
  y = move_node.loc[1]

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

    end_moves = end_locs.map do |this_end_loc|
      puts "valid knight end_move #{this_end_loc}" 
      Move.new(this_end_loc, move_node) end
      


end


def knight_moves( start, dest )


  #QUEUE
  unvisited_moves = Queue.new
  
  #begin move chain
  start_move = Move.new(start)
  
  #dealing with Move objects (parent_loc and loc), root move has no parent_loc
  initial_move_list = available_knight_moves_from(start_move)


  #initial test
  test_arrays = initial_move_list.map do |m| m.loc end
  if test_arrays.include?(dest)
    return test_arrays.find do |array| array==dest end
  end
  
  #initialize unvisited_moves

  initial_move_list.map do |move| unvisited_moves.push(move) end

  matched_node = nil


  #traversal, testing each of the children of nodes in unvisited
  while matched_node.nil? do
    
    test_node = unvisited_moves.pop
    puts "loading with #{test_node.loc}"

    if test_node.loc == dest
      matched_node = test_node 
      puts "#{dest} match found: #{matched_node.loc}"

      puts "parent: #{matched_node.parent_move.loc}"
      puts "parent2: #{matched_node.parent_move.parent_move.loc}"





    end

    available_knight_moves_from(test_node).map do |node|
      unvisited_moves.push(node)
      #puts "#{node.loc} this is pushed"
    end
    
  end
  
  move_set = []
  
  until matched_node.nil? do
    puts "matched_node #{matched_node.loc}"
    move_set << matched_node.loc
    matched_node = matched_node.parent_move
  end
  
  return move_set

end


#test
origin = [7,7]
dest = [1,3]
moves = knight_moves(origin, dest)
puts "Success"
puts "From #{origin} to #{dest}"

moves.size.times do |x| puts "#{moves[-1-x]}" end









