require 'Board'

describe Board do

  describe '.determine_moves' do

    before(:each) do

      @board = Board.new

    end

    describe "for pawn" do

      context "at [0,1] with no enemy in front" do

        it "returns [ [0,2], [0,3] ]" do
          @board.determine_moves([0,1])
          expect(@board.spaces[[0,1]].moveset ).to eql([ [0,2],[0,3] ])
        end

      end

      context "at [0,1] with piece blocking at [0,2]" do

        it "returns empty []" do
          @board.spaces[[0,2]] = Piece.new(type: "pawn", color: "black", location: [0,2])
          @board.determine_moves([0,2])
          expect(@board.spaces[[0,1]].moveset).to eql([])
        end

      end

    end#pawn

    describe "for rook" do

      context "at [0,0] with no moves" do

        it "moveset returns empty set" do
          @board.determine_moves([0,0] )
          expect(@board.spaces[[0,0]].moveset).to eql([])
        end

        it "attackset returns empty set" do
          @board.determine_moves([0,0] )
          expect(@board.spaces[[0,0]].attackset).to eql([])
        end

      end

      context "rook at [0,0] with no pawn in front" do

        before(:each) do
          @board.spaces[ [0,1] ] = nil
          @board.determine_moves( [0,0 ])
          
          @result_array = []
          1.upto(5) do |x| @result_array << [0,x] end
        end

        it "moveset returns [0,1]..[0,5]" do
          
          expect(@board.spaces[ [0,0] ].moveset).to eql(@result_array)

        end

        it "attackset returns [0,6]" do

          expect(@board.spaces[ [0,0] ].attackset).to eql([[0,6]])

        end

      end

      context "at [0,0] with no horse on right" do

        it "moveset returns [1,0]" do

          @board.spaces[ [1,0] ] = nil
          @board.determine_moves( [0,0 ])
          expect(@board.spaces[ [0,0] ].moveset).to eql([[1,0]])
        end

      end

      context "at [0,0] with enemy pawn in front and to right" do

        it "attackset returns [ [1,0], [0,1] ]" do

          @board.spaces[ [1,0] ] = Piece.new({type: "rook", location: [1,0], color: "black"})
          @board.spaces[ [0,1] ] = Piece.new({type: "rook", location: [0,1], color: "black"})
          @board.determine_moves( [0,0])
          expect(@board.spaces[ [0,0] ].attackset).to eql([[0,1],[1,0]])

        end

      end

      context "at [4,3]" do 

        it "returns lots of shit" do

          @board.spaces[ [4,3] ] = Piece.new({type: "rook", location: [4,3], color: "white"})
          @board.determine_moves( [4,3] )
          expect(@board.spaces[ [4,3] ].moveset).to eql( [[4, 4], [4, 5], [5, 3], [6, 3], [7, 3], [4, 2], [3, 3], [2, 3], [1, 3], [0, 3]] ) 
        end

      end

    end#desc rook

    describe "for bishop" do 

      context "at [2,0] no moves" do

        it "returns empty set" do
          @board.determine_moves( [2,0] )
          expect(@board.spaces[ [2,0] ].moveset).to eql([])
        end

      end

      context "at [2,2]" do 
        before(:each) do
        @board.spaces[ [2,2] ] = Piece.new( {type: "bishop", color: "white", location: [2,2]} )
        @board.determine_moves( [2,2])
        end

        it "attackset = [6,6]" do
          expect(@board.spaces[ [2,2] ].attackset).to eql( [ [6,6] ] )
        end

        it "moveset = ton of shit" do
          expect(@board.spaces[ [2,2] ].moveset).to eql( [ [] ] )
        end


      end

   end#desc bishop




  end#.determine_moves



  describe '.move_piece' do

    before(:each) do

      @board = Board.new

    end

    describe "for pawn" do

      context "when white moves pawn [0,1] up one" do

        it "results in pawn [0,1] moving to [0,2]" do

          @board.move_piece( [0,1], [0,2] )
          
          expect(@board.spaces[[0,2]].type).to eql("pawn")
        
        end

      end

      context "when white pawn attacks black piece" do

        it "results in pawn [0,1] taking [1,2]" do

        @board.spaces[[1,2]] = Piece.new(type: "pawn", color: "black", location: [1,2])
        @board.move_piece( [0,1], [1,2] )
        expect(@board.spaces[ [1,2] ].color).to eql("white")
        end

      end
    end #pawns

    describe "for rook" do

    end



  end#.movepiece





end#Board