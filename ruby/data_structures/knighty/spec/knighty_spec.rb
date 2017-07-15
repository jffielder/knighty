#/knighty/spec/knighty_spec.rb

require "knighty"

describe "knight_moves" do 
  describe "[0,0]" do
    context "to [1,2]" do
      it "returns [0,0] [1,2] [1,2]" do
        expect(knight_moves([0,0], [1,2])).to eql([[0,0], [1,2]])
      end
    end

    context "to [0,2]" do
      it "returns [0,0], [1,2], [0,2]" do
        expect(knight_moves([0,0], [0,2])).to eql([[0,0], [1,2], [0,2]])
      end
    end
    
  end
end