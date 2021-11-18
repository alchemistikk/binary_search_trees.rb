# Do not use duplicate values
arr = [1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324]

class Node
  include Comparable
  attr_accessor :data, :left, :right

  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other)
    @data <=> other.data
  end
end

class Tree
  attr_accessor :root

  def initialize(arr)
    @root = build_tree(arr)
  end

  def build_tree(raw)
    return if raw.empty?

    arr = raw.uniq.sort

    middle = arr.length / 2

    root = Node.new(arr[middle])
    root.left = build_tree(arr[0...middle])
    root.right = build_tree(arr[middle + 1..-1])
    root 
  end
end

my_tree = Tree.new(arr)
puts my_tree.build_tree(arr)

