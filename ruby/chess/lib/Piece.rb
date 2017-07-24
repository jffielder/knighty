

class Piece
  attr_accessor :color, :type, :graphic, :moveset, :attackset, :location


  def set_moveset
    #pawn  
    #unique

    #rook
    #unique rules

    #horse
    [ [1, 2 ],
      [1, -2],
      [-1, 2],
      [-1, -2],
      [2, 1 ],
      [2, -1],
      [-2, 1],
      [-2, -1] ]

      #bishop

      #queen

      #king
      #unique rules

  end#set_moveset

  def set_graphic

    if @color == "white"
      white_types = {
        "pawn"   => "♙",
        "rook"   => "♖",
        "knight" => "♘",
        "bishop" => "♗",
        "queen"  => "♕",
        "king"   => "♔",
      } 

      @graphic = white_types[@type]

    elsif @color == "black"
      black_types = {
        "pawn"   => "♟",
        "rook"   => "♜",
        "knight" => "♞",
        "bishop" => "♝",
        "queen"  => "♛",
        "king"   => "♚",
      }

      @graphic = black_types[@type]
    end
  end

  def initialize(params)

    @color = params[:color]

    @type = params[:type]

    @location = params[:location]

    @moveset = []

    @attackset = []

    set_graphic

  end




end#piece



def test_it
pawn = Piece.new({:color => "white", :type => "pawn" } )

puts "#{pawn.color}"

puts "#{pawn.graphic}"

end