#!/usr/bin/env_ruby
require_relative 'Piece.rb'
class Board

  attr_accessor :spaces, :player
    

  def initialize
    #pawns
    @spaces = {}
    8.times do |x|
      @spaces[[x,1]] = Piece.new(type: "pawn", color: "white", :location => [x,1])
    end

    8.times do |x|
      @spaces[[x,6]] = Piece.new({:type => "pawn", :color => "black", :location => [x,6]})
    end
    #rooks
    @spaces[[0,0]] = Piece.new({:type => "rook", :color => "white", :location => [0,0] })
    @spaces[[7,0]] = Piece.new({:type => "rook", :color => "white",:location => [7,0]})

    @spaces[[0,7]] = Piece.new({:type => "rook", :color => "black", :location => [0,7]})
    @spaces[[7,7]] = Piece.new({:type => "rook", :color => "black", :location => [7,7]})

    #horses
    @spaces[[1,0]] = Piece.new({:type => "knight", :color => "white", :location => [1,0]} )
    @spaces[[6,0]] = Piece.new({:type => "knight", :color => "white", :location => [6,0]} )

    @spaces[[1,7]] = Piece.new({:type => "knight", :color => "black", :location => [1,7]} )
    @spaces[[6,7]] = Piece.new({:type => "knight", :color => "black", :location => [6,7]} )

    #bishops
    @spaces[[2,0]] = Piece.new({:type => "bishop", :color => "white", :location => [2,0]})
    @spaces[[5,0]] = Piece.new({:type => "bishop", :color => "white", :location => [5,0]})

    @spaces[[2,7]] = Piece.new({:type => "bishop", :color => "black", :location => [2,7]})
    @spaces[[5,7]] = Piece.new({:type => "bishop", :color => "black", :location => [5,7]})

    #queen
    @spaces[[3,0]] = Piece.new({:type => "queen", :color => "white", :location => [3,0]})

    @spaces[[3,7]] = Piece.new({:type => "queen", :color => "black", :location => [3,7]})

    #king
    @spaces[[4,0]] = Piece.new({:type => "king", :color => "white", :location => [4,0]})

    @spaces[[4,7]] = Piece.new({:type => "king", :color => "black", :location => [4,7]})

    @player = "white"

  end

  def switch_player
    if @player == "white"
      @player = "black"
    elsif @player == "black"
      @player = "white"
    end
    return true
  end


  #returns nothing, sets piece.moveset and piece.attackset
  def determine_moves(loc)

    piece = @spaces[loc]

    moveset = []
    attackset = []
    new_moves = []

    x = loc[0]
    y = loc[1]

    enemy_king_checked = false


    case piece.type

    when "pawn"

      if piece.color == "white"

        new_moves << [x, y+1]
        new_moves << [x,y+2] if y == 1

        if @spaces[new_moves[0]].nil?

          moveset << new_moves[0]
          moveset << new_moves[1] if y == 1

        end

        atk_moves = [[x+1, y+1], [x-1, y+1]]
        atk_moves.each do |move|
          attackset << move if @spaces[move].nil?.! and @spaces[move].color == "black"
          if @spaces[move].nil?.!
          enemy_king_checked = true if @spaces[move].color == "black" and @spaces[move].type == "king"
          end
        end
        

      elsif piece.color == "black"

        new_moves = [[x, y-1]]
        new_moves << [x,y-2] if y == 6

        if @spaces[new_moves[0]].nil?

          moveset << new_moves[0]
          moveset << new_moves[1] if loc[1] == 6

        end

        atk_moves = [[x+1, y-1], [x-1, y-1]]
        atk_moves.each do |move|
          attackset << move if @spaces[move].nil?.! and @spaces[move].color == "white"
          if @spaces[move].nil?.!
          enemy_king_checked = true if @spaces[move].color == "white" and @spaces[move].type == "king"
          end
        end
      end

      @spaces[loc].moveset = moveset
      @spaces[loc].attackset = attackset
            

    when "rook"

      runner(loc, :north)
      runner(loc, :east)
      runner(loc, :south)
      runner(loc, :west)

    when "knight"

      possible_directions =
      [ [x+1, y+2],
        [x+1, y-2],
        [x-1, y+2],
        [x-1, y-2],
        [x+2, y+1],
        [x+2, y-1],
        [x-2, y+1],
        [x-2, y-1] ]

      moveset = possible_directions.select do |d|
        (d[0].between?(0,7) & d[1].between?(0,7)) and @spaces[d].nil?
      end

      attackset = possible_directions.select do |d|
        (d[0].between?(0,7) & d[1].between?(0,7)) and (@spaces[d].nil?.! and @spaces[d].color != @spaces[loc].color)
      end

      @spaces[loc].moveset = moveset
      @spaces[loc].attackset = attackset


    when "bishop"

      runner(loc, :northeast)
      runner(loc, :southeast)
      runner(loc, :northwest)
      runner(loc, :southwest)


    when "queen"

      runner(loc, :north)
      runner(loc, :northeast)
      runner(loc, :east)
      runner(loc, :southeast)
      runner(loc, :south)
      runner(loc, :southwest)
      runner(loc, :west)
      runner(loc, :northwest)


    when "king"

      runner(loc, :north, 1)
      runner(loc, :northeast, 1)
      runner(loc, :east, 1)
      runner(loc, :southeast, 1)
      runner(loc, :south, 1)
      runner(loc, :southwest, 1)
      runner(loc, :west, 1)
      runner(loc, :northwest, 1)

    end


  end #determin_moves

  def runner(start, direction, length = 7)
    #north = [0,1]
    cardinal = {north: [0,1], northeast: [1,1], east: [1,0], southeast: [1,-1],
                south: [0,-1], southwest: [-1,-1], west: [-1,0], northwest: [-1,1]}

    modifier = cardinal[direction]

    runner = [start[0] + modifier[0], start[1] + modifier[1] ]

    moveset = []

    #traveled limits while loop to length
    traveled = 0

    #build moveset
    while @spaces[runner].nil? and (runner[0].between?(0,7) and runner[1].between?(0,7)) and traveled != length
      moveset << runner
      runner = [runner[0] + modifier[0], runner[1] + modifier[1] ]
      traveled += 1
    end

    #assign attackset
    if @spaces[runner].nil?.!
      if @spaces[runner].color != @player
        @spaces[start].attackset << @spaces[runner].location
      end
    end
      #assign moveset
      if moveset.size > 0
        @spaces[start].moveset += moveset
      end
  end


  def in_check  
  end

  def checkmate
  end

  def promotion
  end



  #return true if valid move, false if invalid move
  def move_piece(start, dest)

    determine_moves(start)

    #puts "dest movem valid?: #{@spaces[start].moveset.include?(dest)}"

    #puts "dest atack valid?: #{@spaces[start].attackset.include?(dest)}"
    return false if @spaces[start].color != @player || 
                @spaces[start].moveset.include?(dest).! and @spaces[start].attackset.include?(dest).!

 #TODO   #return false if in_check

    @spaces[dest] = @spaces[start]

    @spaces[dest].location = dest

    @spaces[start] = nil

    return true

  end

  def draw
    7.downto(0) do |y|
      
      puts ""
      print "#{y}|"
      
      8.times do |x|
        
        if @spaces[[x,y]].nil?.!
          print " #{@spaces[[x,y]].graphic}"
        elsif (x.even? and y.even?) or (x.odd? and y.odd?)
          print " ◌"
        elsif (x.even? and y.odd?) or (x.odd? and y.even?)
          print " ◌"
        end


      end
    end
    puts ""
    puts " |_____________________"
    print "   0  1 2  3 4  5 6  7 \n"
  end#draw


end#board

