class Node
  attr_accessor :parent, :real

  def initialize (real, parent = nil)
    @real = real
    @parent = parent
  end
end

def test

  first = Node.new([1,2])