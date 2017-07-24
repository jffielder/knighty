

class Piece
  attr_accessor :color, :type, :graphic, :moveset, :attackset, :location

  def graphic

    if @color == "white"
      white_types = {
        "pawn"   => "♙",
        "rook"   => "♖",
        "knight" => "♘",
        "bishop" => "♗",
        "queen"  => "♕",
        "king"   => "♔",
      } 

      return white_types[@type]

    elsif @color == "black"
      black_types = {
        "pawn"   => "♟",
        "rook"   => "♜",
        "knight" => "♞",
        "bishop" => "♝",
        "queen"  => "♛",
        "king"   => "♚",
      }

      return black_types[@type]
    end
  end

  def initialize(params)

    @color = params[:color]

    @type = params[:type]

    @location = params[:location]

    @moveset = []

    @attackset = []

    @graphic = graphic

  end




end#piece



def test_it
pawn = Piece.new({:color => "white", :type => "pawn" } )

puts "#{pawn.color}"

puts "#{pawn.graphic}"

end