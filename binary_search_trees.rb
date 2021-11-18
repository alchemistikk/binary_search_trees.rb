# Do not use duplicate values
arr = [1, 2, 3, 4, 5, 6, 7]

class Node
  include Comparable

  def initalize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  def initialize(arr)
    @arr = arr
  end

  @root = build_tree
end
